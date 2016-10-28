module Main exposing (..)

import Html exposing (Html, div, h2, button, text, img)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Window exposing (Size)
import Model exposing (..)
import CpamModel exposing (..)
import CpamView exposing (..)
import Time exposing (Time, minute, second)
import View exposing (..)
import Api exposing (..)
import PainelNavigation exposing (..)
import Navigation
import Http
import Task
import Debug


main : Program Never
main =
    Navigation.program
        (Navigation.makeParser hasParser)
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { view : AppView
    , asa : Maybe String
    , rooms : List Room
    , date : String
    , size : Window.Size
    , scale : Float
    , loading : Bool
    , subs : Maybe Int
    , version : String
    , page : Page
    , cpam : Maybe CpamJson
    }


type AppView
    = HomeView
    | AsaView
    | CpamView
    | FarmaciaView


init : Result String Page -> ( Model, Cmd Msg )
init result =
    urlUpdate result
        (Model
            HomeView
            Nothing
            []
            "Loading"
            { width = 1920, height = 1080 }
            1.0
            False
            Nothing
            ""
            Home
            Nothing
        )


urlUpdate : Result String Page -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
    case result of
        Err _ ->
            ( model, Navigation.modifyUrl (toHash model.page) )

        Ok (Home as page) ->
            ( { model | view = HomeView, page = page, asa = Nothing, loading = False, subs = Nothing, cpam = Nothing }, setScale )

        Ok ((Asa asa) as page) ->
            ( { model | view = AsaView, page = page, asa = Just asa, loading = True, subs = Just 1, cpam = Nothing }, getPainel asa )

        Ok (Cpam as page) ->
            ( { model | view = CpamView, page = page, asa = Nothing, loading = True, subs = Just 2 }, setScaleCpam )

        Ok (Farmacia as page) ->
            ( { model | view = FarmaciaView, page = page, asa = Nothing, loading = True, subs = Just 2 }, setScaleCpam )



-- UDATE


type Msg
    = PickAsa (Maybe String)
    | MorePlease Time
    | MorePleaseCpam Time
    | PainelSucceed PainelJson
    | CpamSucceed CpamJson
    | FetchFail Http.Error
    | RollItems Time
    | RollListItems Time
    | RollItemsCpam Time
    | RollListItemsCpam Time
    | Resize Size
    | ResizeCpam Size


resizeCmd : Model -> Size -> Cmd Msg -> ( Model, Cmd Msg )
resizeCmd model newSize cmd =
    let
        scale =
            (toFloat newSize.width) / 1920.0
    in
        ( { model | size = newSize, scale = scale }, cmd )


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        PickAsa newAsa ->
            case newAsa of
                Nothing ->
                    ( { model | asa = Nothing, rooms = [], subs = Nothing }, Navigation.modifyUrl "#home" )

                Just asa ->
                    ( model, Navigation.modifyUrl (toHash (Asa asa)) )

        MorePlease newTime ->
            case model.asa of
                Nothing ->
                    ( model, Cmd.none )

                Just asa ->
                    ( { model | loading = True }, getPainel asa )

        MorePleaseCpam newTime ->
            ( { model | loading = True }, getCpam )

        PainelSucceed painelJson ->
            let
                painel =
                    painelJsonToModel painelJson
            in
                ( { model | rooms = painel.rooms, loading = False, date = painel.date, version = painel.version }, setScale )

        CpamSucceed cpamJson ->
            ( { model | cpam = Just cpamJson, loading = False, date = cpamJson.date, version = cpamJson.version }, setScale )

        FetchFail e ->
            let
                t =
                    Debug.log (toString e) 0
            in
                ( { model | loading = False }, setScale )

        RollItems newTime ->
            rollItems model

        RollListItems newTime ->
            rollListItems model

        RollItemsCpam newTime ->
            rollItemsCpam model

        RollListItemsCpam newTime ->
            ( model, Cmd.none )

        Resize newSize ->
            resizeCmd model newSize Cmd.none

        ResizeCpam newSize ->
            resizeCmd model newSize getCpam


rollItemsCpam : Model -> ( Model, Cmd Msg )
rollItemsCpam model =
    case model.cpam of
        Nothing ->
            ( model, Cmd.none )

        Just cpam ->
            let
                currentSetor =
                    case (List.head <| List.drop cpam.setorCount cpam.setores) of
                        Nothing ->
                            emptySetorCpam

                        Just s ->
                            s

                maxPageCount =
                    floor ((toFloat <| List.length currentSetor.pacientes) / 20)

                lastPage =
                    (currentSetor.pageCount >= (maxPageCount - 1))

                lastSetor =
                    (cpam.setorCount >= ((List.length cpam.setores) - 1))

                nextPageCount =
                    if lastPage then
                        0
                    else
                        currentSetor.pageCount + 1

                nextSetorCount =
                    if lastPage then
                        if lastSetor then
                            0
                        else
                            cpam.setorCount + 1
                    else
                        cpam.setorCount

                nextCpamSetor =
                    { currentSetor | pageCount = nextPageCount }

                nextSetores =
                    (List.take cpam.setorCount cpam.setores) ++ [ nextCpamSetor ] ++ (List.drop (cpam.setorCount + 1) cpam.setores)

                nextCpam =
                    { cpam | setorCount = nextSetorCount, setores = nextSetores }
            in
                ( { model | cpam = (Just nextCpam) }, Cmd.none )


rollItems : Model -> ( Model, Cmd Msg )
rollItems model =
    if (List.length model.rooms) > 20 then
        let
            head =
                List.take 5 model.rooms

            tail =
                List.drop 5 model.rooms

            tempList =
                List.append tail head

            updatedList =
                List.indexedMap updateRoomIndex tempList
        in
            ( { model | rooms = updatedList }, Cmd.none )
    else
        ( model, Cmd.none )


shiftListString : List String -> List String
shiftListString listStr =
    if (List.length listStr) > 3 then
        let
            headList =
                List.take 1 listStr

            tailList =
                List.drop 1 listStr
        in
            List.append tailList headList
    else
        listStr


rollListItems : Model -> ( Model, Cmd Msg )
rollListItems model =
    let
        updatedRoomsList =
            List.map (\r -> { r | alergias = (shiftListString r.alergias), exames = (shiftListString r.exames), cirurgias = (shiftListString r.cirurgias) }) model.rooms
    in
        ( { model | rooms = updatedRoomsList }, Cmd.none )



-- VIEW


loadingLayer : Model -> Html Msg
loadingLayer model =
    let
        display =
            if model.loading then
                "block"
            else
                "none"
    in
        div [ class "loadingLayer", style [ ( "display", display ) ] ]
            [ img [ class "loadingLayer--image", src "assets/imgs/logo.png", width 500 ] []
            , img [ class "loadingLayer--gif", src "assets/imgs/loading.gif", width 100 ] []
            ]


printModel : Model -> Html Msg
printModel model =
    h2 [] [ text (toString model) ]


listRooms : String -> Model -> List (Html Msg)
listRooms asa model =
    [ header (asaTitle asa) model.date model.version model.loading (PickAsa Nothing)
    , columnHeaderASA
    , roomsToHtml model.rooms
    , loadingLayer model
    ]


cpamListRooms : String -> Model -> List (Html Msg)
cpamListRooms title model =
    let
        cpam =
            case model.cpam of
                Just c ->
                    c

                Nothing ->
                    CpamJson "" "" [] 0

        currentSetor =
            case (List.head <| List.drop cpam.setorCount cpam.setores) of
                Just s ->
                    s

                Nothing ->
                    SetorCpamJson ("Carregando...") [] 0
    in
        [ header (title ++ currentSetor.nome) model.date model.version model.loading (PickAsa Nothing)
        , headerCpam
        , cpamSetorToHtml currentSetor
        ]


asas : List ( String, String )
asas =
    [ ( "homero", "HOMERO MASSENA" )
    , ( "augusto", "AUGUSTO RUSCHI" )
    , ( "cora", "CORA CORALINA" )
    , ( "monteiro", "MONTEIRO LOBATO" )
    , ( "rubem", "RUBEM BRAGA" )
    , ( "dayclinic", "DAY CLINIC" )
    , ( "uti2", "UTI 2 + CARDIOLOGIA" )
    , ( "uti1", "UTI 1" )
    , ( "ctq", "CTQ" )
    ]


asaTitle : String -> String
asaTitle asa =
    let
        filterAsa =
            \a ->
                (fst a) == asa

        result =
            List.head <| List.filter filterAsa asas

        ( f, title ) =
            case result of
                Nothing ->
                    ( "na", "NOTHING" )

                Just t ->
                    t
    in
        title


asaToButton : ( String, String ) -> Html Msg
asaToButton tuple =
    let
        ( asa, title ) =
            tuple
    in
        button [ class "button__asa", onClick (PickAsa (Just asa)) ] [ text title ]


asaSelection : List (Html Msg)
asaSelection =
    [ div [] (List.map asaToButton asas) ] ++ [ legendas ]


view : Model -> Html Msg
view model =
    let
        content =
            case model.view of
                HomeView ->
                    asaSelection

                AsaView ->
                    case model.asa of
                        Nothing ->
                            asaSelection

                        Just asa ->
                            listRooms asa model

                CpamView ->
                    cpamListRooms "CPAM - " model

                FarmaciaView ->
                    cpamListRooms "FARMÁCIA - " model
    in
        div [ id "app", class "app", style [ ( "transform", "scale(" ++ (toString model.scale) ++ ")" ) ] ]
            content



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.subs of
        Just 1 ->
            Sub.batch
                [ Time.every (5 * minute) MorePlease
                , Time.every (10 * second) RollItems
                , Time.every (1 * second) RollListItems
                , Window.resizes Resize
                ]

        Just 2 ->
            Sub.batch
                [ Time.every (5 * minute) MorePleaseCpam
                , Time.every (5 * second) RollItemsCpam
                , Time.every (1 * second) RollListItemsCpam
                , Window.resizes Resize
                ]

        _ ->
            Sub.none



-- HTTP


setScale : Cmd Msg
setScale =
    Task.perform (\_ -> Debug.crash "Oopss!!!") Resize Window.size


setScaleCpam : Cmd Msg
setScaleCpam =
    Task.perform (\_ -> Debug.crash "Oopss!!!") ResizeCpam Window.size


getPainel : String -> Cmd Msg
getPainel asa =
    getJsonPainel asa FetchFail PainelSucceed


getCpam : Cmd Msg
getCpam =
    getJsonCpam FetchFail CpamSucceed
