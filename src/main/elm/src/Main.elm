module Main exposing (..)

import Html exposing (Html, div, h2, button, text)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Json.Decode exposing (Decoder, object2, string, int, (:=))
import Task
import Model exposing (..)
import Time exposing (Time, minute, second)
import Date exposing (Date)
import View exposing (..)
import Window exposing (Size)


main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { rooms : Room
    , users : List UserJson
    , date : String
    , size : Window.Size
    , scale : Float
    }


init : ( Model, Cmd Msg )
init =
    ( Model mockRoom [] "Loading..." { width = 1920, height = 1080 } 1.0, initializeDimensions )



-- UDATE


type Msg
    = MorePlease Time
    | FetchSucceed RoomJson
    | TestSucceed (List UserJson)
    | FetchFail Http.Error
    | TickClock Time
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
            ( { model | date = convertDate newTime }, Cmd.none )

        Resize size ->
            let
                scale =
                    (toFloat size.width) / 1920.0
            in
                ( { model | size = size, scale = scale }, dashBoard )



-- VIEW


printModel : Model -> Html Msg
printModel model =
    h2 [] [ text (toString model) ]


view : Model -> Html Msg
view model =
    div [ id "app", class "app", style [ ( "transform", "scale(" ++ (toString model.scale) ++ ")" ) ] ]
        [ header "HOMERO MASSENA" model.date
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Time.every minute MorePlease
        , Time.every second TickClock
        ]



-- HTTP


initializeDimensions : Cmd Msg
initializeDimensions =
    Task.perform (\_ -> Debug.crash "Oopss!!!") Resize Window.size


convertDate : Time -> String
convertDate time =
    let
        date =
            Date.fromTime time
    in
        (toString <| Date.year <| date)
            ++ "/"
            ++ (toString <| Date.day <| date)
            ++ " "
            ++ (toString <| Date.hour <| date)
            ++ ":"
            ++ (toString <| Date.minute <| date)
            ++ ":"
            ++ (toString <| Date.second <| date)


dashBoard : Cmd Msg
dashBoard =
    Task.perform FetchFail TestSucceed (Http.get testJsonDecoder "https://jsonplaceholder.typicode.com/users")
