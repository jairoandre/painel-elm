module Main exposing (..)
import Html exposing (Html, div, h2, button, text)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Json.Decode exposing (Decoder, object2, string, int, (:=))
import Task
import Model exposing (..)



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
  }

init : (Model, Cmd Msg)
init =
  ( Model mockRoom, Cmd.none)


-- UDATE

type Msg
  = MorePlease
  | FetchSucceed RoomJson
  | FetchFail Http.Error


update : Msg -> Model -> (Model, Cmd Msg)
update message model =
  case message of
    MorePlease ->
      (model, dashBoard)

    FetchSucceed json ->
      (model, Cmd.none)

    FetchFail _ ->
      (model, Cmd.none)



-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ h2 [] [ text (toString model) ]
    ]

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- HTTP

dashBoard : Cmd Msg
dashBoard =
  Task.perform FetchFail FetchSucceed (Http.get roomJsonDecoder "rest/api/painel")
