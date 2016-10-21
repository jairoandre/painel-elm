module Main exposing (..)

import Html exposing (Html, div, h2, button, text, img)
import Navigation
import UrlParser exposing (Parser, (</>), format, int, oneOf, s, string)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Date exposing (Date)
import Window exposing (Size)
import Http
import Task
import Debug
import String

import Model exposing (..)
import Mock exposing (..)
import Time exposing (Time, minute, second)
import View exposing (..)
import Utils exposing (..)
import Api exposing (..)


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


-- URL PARSERS

toHash : Page -> String
toHash page =
  case page of
    Home ->
      "#home"

    Asa asa ->
      "#painel/" ++ asa

hasParser : Navigation.Location -> Result String Page
hasParser location =
    UrlParser.parse identity pageParser (String.dropLeft 1 location.hash)

pageParser : Parser (Page -> a) a
pageParser =
    oneOf
        [ format Home (s "Home")
        , format Asa (s "painel" </> string)
        ]

type Page
    = Home
    | Asa String


-- MODEL


type alias Parse =
    { url : String
    , asa : String
    }


type alias Model =
    { asa : Maybe String
    , rooms : List Room
    , date : String
    , size : Window.Size
    , scale : Float
    , loading : Bool
    , subs : Maybe Int
    , version : String
    }


init : Result String Page -> ( Model, Cmd Msg )
init result =
    urlUpdate result ( Model Nothing [] "Loading" { width = 1920, height = 1080 } 1.0 False Nothing "", initializeDimensions )

urlUpdate : Result String Page -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
    case Debug.log "result" result of
        Err _ ->
            ( model, Navigation.modifyUrl (toHash model.page) )

        Ok (Asa asa as page) ->
            ( { model | page = page, asa = asa }, getPainel asa )



-- UDATE


type Msg
    = PickAsa (Maybe String)
    | MorePlease Time
    | PainelSucceed PainelJson
    | FetchFail Http.Error
    | RollItems Time
    | RollListItems Time
    | Resize Size


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        PickAsa newAsa ->
            case newAsa of
                Nothing ->
                    ( { model | asa = Nothing, rooms = [], subs = Nothing }, Cmd.none )

                Just asa ->
                    ( { model | asa = Just asa, loading = True, subs = Just 1 }, getPainel asa )

        MorePlease newTime ->
            case model.asa of
                Nothing ->
                    ( model, Cmd.none )

                Just asa ->
                    ( { model | loading = True }, getPainel asa )

        PainelSucceed painelJson ->
            let
                painel =
                    painelJsonToModel painelJson
            in
                ( { model | rooms = painel.rooms, loading = False, date = painel.date, version = painel.version }, Cmd.none )

        FetchFail e ->
            ( { model | loading = False }, Cmd.none )

        RollItems newTime ->
            rollItems model

        RollListItems newTime ->
            rollListItems model

        Resize size ->
            let
                scale =
                    (toFloat size.width) / 1920.0
            in
                ( { model | size = size, scale = scale }, Cmd.none )


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
    [ header (asaTitle asa) model.date model.version (PickAsa Nothing)
    , columnHeaderASA
    , roomsToHtml model.rooms
    , loadingLayer model
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
            case model.asa of
                Nothing ->
                    asaSelection

                Just asa ->
                    listRooms asa model
    in
        div [ id "app", class "app", style [ ( "transform", "scale(" ++ (toString model.scale) ++ ")" ) ] ]
            content



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.subs of
        Nothing ->
            Sub.none

        Just _ ->
            Sub.batch
                [ Time.every (5 * minute) MorePlease
                , Time.every (10 * second) RollItems
                , Time.every (1 * second) RollListItems
                , Window.resizes Resize
                ]



-- HTTP


initializeDimensions : Cmd Msg
initializeDimensions =
    Task.perform (\_ -> Debug.crash "Oopss!!!") Resize Window.size


getPainel : String -> Cmd Msg
getPainel asa =
    getJsonPainel asa FetchFail PainelSucceed
