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
            [ div [ class "title__wrapper--inner" ] [ text title ] ]
        , div [ class "date__wrapper" ]
            [ text date ]
        ]


columnH : String -> String -> Html a
columnH title classR =
    div [ class ("column__header column__header--" ++ classR) ]
        [ div [ class "column__header__inner" ]
            [ text title ]
        ]


columnHeader : Html a
columnHeader =
    div
        [ class "column__header__wrapper" ]
        [ columnH "ESPECIALIDADE" "specialty"
        , columnH "CLASS. RISCO" "risk"
        , columnH "PACIENTE" "patient"
        , columnH "CONVÊNIO" "convenio"
        , columnH "OBSERVAÇÃO" "obs"
        , columnH "LOCALIZ." "localizacao"
        , columnH "TEMPO PERM." "tempo"
        , columnH "ALERGIA" "alergia"
        , columnH "EXAMES" "exame"
        , columnH "PROTOC." "protocolo"
        , columnH "SOLIC. INT." "internacao"
        ]
