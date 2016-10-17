module View exposing (..)

import Html exposing (Html, div, img, h2, button, text)
import Html.Attributes exposing (..)
import Model exposing (..)
import Time
import Task
import Svg
import Svg.Attributes as SvgAtt


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
        , columnHC "PRECAU." "precaucao"
        , columnHC "SCP" "scp"
        , columnHC "RIS. QUEDA" "risco"
        , columnHC "ÚLC. PRES." "ulcera"
        , columnHC "ALERGIA" "alergiaASA"
        , columnHC "EXAMES" "exameASA"
        , columnHC "CIRURGIA" "cirurgia"
        , columnHC "JEJUM" "jejum"
        ]


columnTextPadding : String -> String -> Html a
columnTextPadding value classR =
    div [ class ("column__wrapper column__wrapper--" ++ classR) ]
        [ div [ class "column__wrapper--padding" ]
            [ text value ]
        ]


columnTextCenter : String -> String -> Html a
columnTextCenter value classR =
    div [ class ("column__wrapper column__wrapper--" ++ classR) ]
        [ div [ class "column__wrapper--center" ]
            [ text value ]
        ]


columnHtml : Html a -> String -> Html a
columnHtml content classR =
    div [ class ("column__wrapper column__wrapper--" ++ classR) ]
        [ content ]


roomStatusToHtml : RoomStatus -> Html a
roomStatusToHtml status =
    let
        ( image, classR ) =
            case status of
                Occupied ->
                    ( "man-user.png", "ocupada" )

                MedicalRelease ->
                    ( "man-user.png", "alta" )

                Vacancy ->
                    ( "hotel-single-bed.png", "vago" )

                Companion ->
                    ( "man-user.png", "acompanhante" )

                Cleaning ->
                    ( "wiping-swipe-for-floors.png", "higienizacao" )

                Reserved ->
                    ( "hotel-door-key.png", "reservada" )

                Maintenance ->
                    ( "handyman-tools.png", "manutencao" )

                Interdicted ->
                    ( "close-sign-for-door.png", "interditado" )

                EmptyRoom ->
                    ( "cancel.png", "empty" )
    in
        img [ src ("assets/imgs/" ++ image), class ("image__icon image__icon--" ++ classR) ] []


precaucaoToHtml : CautionLevel -> Html a
precaucaoToHtml status =
    let
        ( image, classR ) =
            case status of
                Default ->
                    ( "handle-with-care.png", "precaucao--padrao" )

                Preventive ->
                    ( "handle-with-care.png", "precaucao--preventiva" )

                Aerosols ->
                    ( "spray.png", "precaucao--aerossois" )

                Contact ->
                    ( "hand.png", "precaucao--contato" )

                ContactAerosols ->
                    ( "hand-spray.png", "precaucao--contato--aerossois" )

                ContactDroplets ->
                    ( "hand-drops.png", "precaucao--contato--goticulas" )

                Droplets ->
                    ( "drops.png", "precaucao--goticulas" )

                NoCaution ->
                    ( "cancel.png", "precaucao--sem" )
    in
        img [ src ("assets/imgs/" ++ image), class ("image__icon image__icon--" ++ classR) ] []


scpToHtml : RiskLevel -> Html a
scpToHtml scp =
    case scp of
        NoRisk ->
            text ""

        VeryLow ->
            Svg.svg [ SvgAtt.height "40", SvgAtt.width "40" ]
                [ Svg.polygon
                    [ SvgAtt.points "0,40 40,40 20,0"
                    , SvgAtt.fill "green"
                    ]
                    []
                ]

        Low ->
            Svg.svg [ SvgAtt.height "40", SvgAtt.width "40" ]
                [ Svg.circle
                    [ SvgAtt.cx "20"
                    , SvgAtt.cy "20"
                    , SvgAtt.r "20"
                    , SvgAtt.fill "#cc0099"
                    ]
                    []
                ]

        Average ->
            Svg.svg [ SvgAtt.height "40", SvgAtt.width "40" ]
                [ Svg.rect
                    [ SvgAtt.width "40"
                    , SvgAtt.height "40"
                    , SvgAtt.fill "orange"
                    ]
                    []
                ]

        High ->
            Svg.svg [ SvgAtt.height "40", SvgAtt.width "40" ]
                [ Svg.polygon
                    [ SvgAtt.points "20,0 0,18 8,40 32,40 40,18"
                    , SvgAtt.fill "#ff3333"
                    ]
                    []
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

        medico =
            case room.medico of
                Nothing ->
                    "-"

                Just m ->
                    m

        convenio =
            case room.convenio of
                Nothing ->
                    "-"

                Just s ->
                    s

        observacao =
            case room.observacao of
                Nothing ->
                    "-"

                Just s ->
                    s

        previsao =
            case room.previsao of
                Just s ->
                    s

                _ ->
                    "?"

        precaucao =
            case room.precaucao of
                Just p ->
                    precaucaoToHtml p

                Nothing ->
                    text "-"

        scp =
            case room.scp of
                Just p ->
                    scpToHtml p

                Nothing ->
                    text ""
    in
        div [ class rowClass, style [ ( "top", top ) ] ]
            [ columnTextPadding room.apto "apto"
            , columnHtml (roomStatusToHtml room.status) "status"
            , columnTextPadding patient "patient"
            , columnTextPadding medico "medico"
            , columnTextPadding convenio "convenio"
            , columnTextPadding observacao "observacao"
            , columnTextCenter previsao "previsao"
            , columnHtml precaucao "precaucao"
            , columnHtml scp "scp"
            ]


roomsToHtml : List Room -> Html a
roomsToHtml rooms =
    div [ class "rows__wrapper" ]
        (List.map
            roomToHtml
            rooms
        )
