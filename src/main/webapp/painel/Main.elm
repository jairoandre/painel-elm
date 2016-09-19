module Main exposing (..)
import Html exposing (Html, div, h2, button, text)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http
import Json.Decode exposing (Decoder, object2, string, int, (:=))
import Task



main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model =
  { name : String
  , qtd : Int
  }

init : (Model, Cmd Msg)
init =
  ( Model "nothing" 0, Cmd.none)


-- UDATE

type Msg
  = MorePlease
  | FetchSucceed  Model
  | FetchFail Http.Error


update : Msg -> Model -> (Model, Cmd Msg)
update message model =
  case message of
    MorePlease ->
      (model, getPainel)

    FetchSucceed newModel ->
      (newModel, Cmd.none)

    FetchFail _ ->
      (model, Cmd.none)



-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ h2 [] [ text (model.name ++ ": " ++ (toString model.qtd)) ]
    , button [onClick MorePlease] [ text "More Please" ]
    ]

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- HTTP

getPainel : Cmd Msg
getPainel =
  Task.perform FetchFail FetchSucceed (Http.get decodeModel "rest/api/painel")

decodeModel : Decoder Model
decodeModel =
  object2 Model ("name" := string) ("qtd" := int)