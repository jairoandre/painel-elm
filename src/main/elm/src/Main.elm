module Main exposing (..)

import Html exposing (Html, div, h2, button, text)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Json.Decode exposing (Decoder, object2, string, int, (:=))
import Task
import Model exposing (..)
import Time exposing(Time, minute)
import View exposing(..)



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
  }

init : (Model, Cmd Msg)
init =
  ( Model mockRoom [], dashBoard)


-- UDATE

type Msg
  = MorePlease Time
  | FetchSucceed RoomJson
  | TestSucceed (List UserJson)
  | FetchFail Http.Error


update : Msg -> Model -> (Model, Cmd Msg)
update message model =
  case message of
    MorePlease newTime ->
      (model, dashBoard)

    FetchSucceed json ->
      (model, Cmd.none)

    TestSucceed json ->
      ({ model | users = json }, Cmd.none)

    FetchFail _ ->
      (model, Cmd.none)



-- VIEW

printModel : Model -> Html Msg
printModel model =
  h2 [] [text (toString model)]

view : Model -> Html Msg
view model =
  div [id "app", style [("width", "100%")]]
    [ header
    ]

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every minute MorePlease

-- HTTP

dashBoard : Cmd Msg
dashBoard =
  Task.perform FetchFail TestSucceed (Http.get testJsonDecoder "https://jsonplaceholder.typicode.com/users")
