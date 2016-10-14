module View exposing (..)

import Html exposing (Html, div, img, h2, button, text)
import Html.Attributes exposing (..)
import Model exposing (..)
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


columnHC : String -> String -> Html a
columnHC title classR =
    div [ class ("column__header column__header--" ++ classR) ]
        [ div [ class "column__header__inner--center" ]
            [ text title ]
        ]


columnHeaderPS : Html a
columnHeaderPS =
    div
        [ class "column__header__wrapper" ]
        [ columnH "ESPECIALIDADE" "specialty"
        , columnH "CLASS. RISCO" "risk"
        , columnH "PACIENTE" "patient"
        , columnH "CONVÊNIO" "convenio"
        , columnH "OBSERVAÇÃO" "obs"
        , columnH "LOCALIZAÇÃO" "localizacao"
        , columnH "TEMPO PERM." "tempo"
        , columnH "ALERGIA" "alergia"
        , columnH "EXAMES" "exame"
        , columnH "PROTOC." "protocolo"
        , columnH "SOLIC. INT." "internacao"
        ]


columnHeaderASA : Html a
columnHeaderASA =
    div [ class "column__header__wrapper" ]
        [ columnH "APTO" "apto"
        , columnHC "STATUS" "status"
        , columnH "PACIENTE" "pacienteASA"
        , columnH "MÉD. ASSIST." "medicoASA"
        , columnH "CONVÊNIO" "convenioASA"
        , columnH "OBS." "obsASA"
        , columnHC "PREV. ALTA" "previsaoASA"
        , columnHC "PRECAUÇÃO" "precaucao"
        , columnHC "SCP" "scp"
        , columnHC "RIS. QUEDA" "risco"
        , columnHC "ÚLC. PRES." "ulcera"
        , columnHC "ALERGIA" "alergiaASA"
        , columnHC "EXAMES" "exameASA"
        , columnHC "CIRURGIA" "cirurgia"
        , columnHC "JEJUM" "jejum"
        ]


columnTextASA : String -> String -> Html a
columnTextASA value classR =
    div [ class ("columnASA__wrapper columnASA__wrapper--" ++ classR) ]
        [ div [ class "column__wrapper--padding" ]
            [ text value ]
        ]


roomToHtml : Room -> Html a
roomToHtml room =
    let
        top =
            (toString (50 * room.idx)) ++ "px"

        rowClass =
            if room.idx % 2 == 0 then
                "row__wrapper"
            else
                "row__wrapper row__wrapper--zebra"

        patient =
            case room.patient of
                Nothing ->
                    "-"

                Just s ->
                    s

        physician =
            case room.physician of
                Nothing ->
                    "-"

                Just m ->
                    m
    in
        div [ class rowClass, style [ ( "top", top ) ] ]
            [ columnTextASA room.apto "apto"
            , columnTextASA (toString room.status) "status"
            , columnTextASA patient "patient"
            , columnTextASA physician "physician"
            ]


roomsToHtml : List Room -> Html a
roomsToHtml rooms =
    div [ class "rows__wrapper" ]
        (List.map
            roomToHtml
            rooms
        )
