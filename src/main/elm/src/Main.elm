module Main exposing (..)

import Html exposing (Html, div, h2, button, text, img)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Json.Decode exposing (Decoder, object2, string, int, (:=))
import Task
import Model exposing (..)
import Mock exposing (..)
import Time exposing (Time, minute, second)
import Date exposing (Date)
import View exposing (..)
import Window exposing (Size)
import Utils exposing (..)
import AnimationFrame
import Ease
import Debug


main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { rooms : List Room
    , users : List UserJson
    , date : String
    , size : Window.Size
    , scale : Float
    , loadOpacity : Float
    }


init : ( Model, Cmd Msg )
init =
    ( Model mockRooms [] "Loading..." { width = 1920, height = 1080 } 1.0 1.0, initializeDimensions )



-- UDATE


type Msg
    = MorePlease Time
    | FetchSucceed RoomJson
    | TestSucceed (List UserJson)
    | FetchFail Http.Error
    | TickClock Time
    | RollItems Time
    | RollListItems Time
    | FadeOutLoading Time
    | Resize Size


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        MorePlease newTime ->
            ( model, dashBoard )

        FetchSucceed json ->
            ( model, Cmd.none )

        TestSucceed json ->
            ( { model | users = json }, Cmd.none )

        FetchFail _ ->
            ( model, Cmd.none )

        TickClock newTime ->
            ( { model | date = timeToStr newTime }, Cmd.none )

        RollItems newTime ->
            rollItems model

        RollListItems newTime ->
            rollListItems model

        FadeOutLoading diff ->
            let
                newOpacity =
                    if model.loadOpacity <= 0 then
                        0.0
                    else
                        model.loadOpacity * 0.25
            in
                ( { model | loadOpacity = newOpacity }, Cmd.none )

        Resize size ->
            let
                scale =
                    (toFloat size.width) / 1920.0
            in
                ( { model | size = size, scale = scale }, dashBoard )


rollItems : Model -> ( Model, Cmd Msg )
rollItems model =
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


shiftListString : List String -> List String
shiftListString listStr =
    let
        headList =
            List.take 1 listStr

        tailList =
            List.drop 1 listStr
    in
        List.append tailList headList


rollListItems : Model -> ( Model, Cmd Msg )
rollListItems model =
    let
        updatedRoomsList =
            List.map (\r -> { r | alergias = (shiftListString r.alergias), exames = (shiftListString r.exames) }) model.rooms
    in
        ( { model | rooms = updatedRoomsList }, Cmd.none )



-- VIEW


loadingLayer : Model -> Html Msg
loadingLayer model =
    div [ class "loadingLayer", style [ ( "display", "none" ) ] ]
        [ img [ class "loadingLayer--image", src "assets/imgs/logo.png", width 500 ] []
        ]


printModel : Model -> Html Msg
printModel model =
    h2 [] [ text (toString model) ]


view : Model -> Html Msg
view model =
    div [ id "app", class "app", style [ ( "transform", "scale(" ++ (toString model.scale) ++ ")" ) ] ]
        [ header "HOMERO MASSENA" model.date
          --, columnHeaderPS
        , columnHeaderASA
        , roomsToHtml model.rooms
        , loadingLayer model
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Time.every minute MorePlease
        , Time.every (10 * second) RollItems
        , Time.every (3 * second) RollListItems
        , Time.every second TickClock
          -- , AnimationFrame.diffs FadeOutLoading
        , Window.resizes Resize
        ]



-- HTTP


initializeDimensions : Cmd Msg
initializeDimensions =
    Task.perform (\_ -> Debug.crash "Oopss!!!") Resize Window.size


dashBoard : Cmd Msg
dashBoard =
    Task.perform FetchFail TestSucceed (Http.get testJsonDecoder "https://jsonplaceholder.typicode.com/users")
