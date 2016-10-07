module View exposing(..)

import Html exposing (Html, div, img, h2, button, text)
import Html.Attributes exposing (..)



header : Html a
header =
  div [ class "headerWrapper"
      ]
      [ img [ src "assets/imgs/logo.png"
            , width 200] []
      ]