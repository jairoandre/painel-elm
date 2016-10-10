module View exposing (..)

import Html exposing (Html, div, img, h2, button, text)
import Html.Attributes exposing (..)
import Time
import Task


header : String -> String -> Html a
header title date =
    div
        [ class "header__wrapper"
        ]
        [ div [ class "logo__wrapper" ]
            [ img
                [ src "assets/imgs/logo.png" ]
                []
            ]
        , div [ class "title__wrapper" ]
            [ text title ]
        , div [ class "date__wrapper" ]
            [ text date ]
        ]
