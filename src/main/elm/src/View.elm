module View exposing (..)

import Html exposing (Html, div, ul, li, img, h2, h3, span, button, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Model exposing (..)
import Time
import Task
import Svg
import Svg.Attributes as SvgAtt


legendas : Html a
legendas =
    div [ attribute "style" "display: inline-block;" ]
        [ div [ attribute "style" "padding: 5px; margin-left: 20px; display: inline-block;" ]
            [ h3 []
                [ text "STATUS" ]
            , div []
                [ img [ class "image__icon image__icon--vago", src "assets/imgs/hotel-single-bed.png" ]
                    []
                , span []
                    [ text "Quarto Vago" ]
                ]
            , div []
                [ img [ class "image__icon image__icon--ocupada", src "assets/imgs/man-user.png" ]
                    []
                , span []
                    [ text "Paciente Internado" ]
                ]
            , div []
                [ img [ class "image__icon image__icon--alta", src "assets/imgs/man-user.png" ]
                    []
                , span []
                    [ text "Paciente com Alta" ]
                ]
            , div []
                [ img [ class "image__icon image__icon--acompanhante", src "assets/imgs/man-user.png" ]
                    []
                , span []
                    [ text "Acompanhante" ]
                ]
            , div []
                [ img [ class "image__icon image__icon--higienizacao", src "assets/imgs/wiping-swipe-for-floors.png" ]
                    []
                , span []
                    [ text "Quarto em Higienização" ]
                ]
            , div []
                [ img [ class "image__icon image__icon--reservada", src "assets/imgs/hotel-door-key.png" ]
                    []
                , span []
                    [ text "Quarto Reservado" ]
                ]
            , div []
                [ img [ class "image__icon image__icon--manutencao", src "assets/imgs/handyman-tools.png" ]
                    []
                , span []
                    [ text "Quarto em Manutenção" ]
                ]
            , div []
                [ img [ class "image__icon image__icon--interditado", src "assets/imgs/close-sign-for-door.png" ]
                    []
                , span []
                    [ text "Interditado" ]
                ]
            ]
        , div [ attribute "style" "padding: 5px; margin-left: 20px; display: inline-block;" ]
            [ h3 []
                [ text "PRECAUÇÃO DE CONTATO" ]
            , div []
                [ img [ class "image__icon image__icon--precaucao--padrao", src "assets/imgs/hand.png" ]
                    []
                , span []
                    [ text "Padrão" ]
                ]
            , div []
                [ img [ class "image__icon image__icon--precaucao--preventiva", src "assets/imgs/hand.png" ]
                    []
                , span []
                    [ text "Preventiva" ]
                ]
            , div []
                [ img [ class "image__icon image__icon--precaucao--contato", src "assets/imgs/hand.png" ]
                    []
                , span []
                    [ text "Contato" ]
                ]
            , div []
                [ img [ class "image__icon image__icon--precaucao--aerossois", src "assets/imgs/spray.png" ]
                    []
                , span []
                    [ text "Aerossóis" ]
                ]
            , div []
                [ img [ class "image__icon image__icon--precaucao--contato--aerossois", src "assets/imgs/hand-spray.png" ]
                    []
                , span []
                    [ text "Contato + Aerossóis" ]
                ]
            , div []
                [ img [ class "image__icon image__icon--precaucao--goticulas", src "assets/imgs/drops.png" ]
                    []
                , span []
                    [ text "Gotículas" ]
                ]
            , div []
                [ img [ class "image__icon image__icon--precaucao--contato--goticulas", src "assets/imgs/hand-drops.png" ]
                    []
                , span []
                    [ text "Contato + Gotículas" ]
                ]
            , div []
                [ img [ class "image__icon image__icon--precaucao-sem", src "assets/imgs/cancel.png" ]
                    []
                , span []
                    [ text "Sem" ]
                ]
            ]
        , div [ attribute "style" "padding: 5px; margin-left: 20px; display: inline-block;" ]
            [ h3 []
                [ text "SCP" ]
            , div []
                [ Svg.svg [ SvgAtt.height "40", SvgAtt.width "40" ]
                    [ Svg.polygon [ SvgAtt.fill "green", SvgAtt.points "0,40 40,40 20,0" ]
                        []
                    ]
                , span []
                    [ text "Cuidados Mínimos" ]
                ]
            , div []
                [ Svg.svg [ attribute "height" "40", attribute "width" "40" ]
                    [ Svg.rect [ SvgAtt.fill "orange", SvgAtt.height "40", SvgAtt.width "40" ]
                        []
                    ]
                , span []
                    [ text "Cuidados Intermediários" ]
                ]
            , div []
                [ Svg.svg [ SvgAtt.height "40", SvgAtt.width "40" ]
                    [ Svg.circle [ SvgAtt.cx "20", SvgAtt.cy "20", SvgAtt.fill "#cc0099", SvgAtt.r "20" ]
                        []
                    ]
                , span []
                    [ text "Semi Intensivo" ]
                ]
            , div []
                [ Svg.svg [ SvgAtt.height "40", SvgAtt.width "40" ]
                    [ Svg.polygon [ SvgAtt.fill "#ff3333", SvgAtt.points "20,0 0,18 8,40 32,40 40,18" ]
                        []
                    ]
                , span []
                    [ text "Cuidados Intensivos" ]
                ]
            ]
        , div [ attribute "style" "padding: 5px; margin-left: 20px; display: inline-block;" ]
            [ h3 []
                [ text "RISCO QUEDA" ]
            , div []
                [ img [ class "image__icon image__icon--riscoQuedaLow", src "assets/imgs/slide.png" ]
                    []
                , span []
                    [ text "Baixo Risco" ]
                ]
            , div []
                [ img [ class "image__icon image__icon--riscoQuedaHigh", src "assets/imgs/slide.png" ]
                    []
                , span []
                    [ text "Alto Risco" ]
                ]
            ]
        , div [ attribute "style" "padding: 5px; margin-left: 20px; display: inline-block;" ]
            [ h3 []
                [ text "ÚLCERA PRESSÃO" ]
            , div []
                [ img [ class "image__icon image__icon--ulceraLow", src "assets/imgs/bed.png" ]
                    []
                , span []
                    [ text "Baixo Risco" ]
                ]
            , div []
                [ img [ class "image__icon image__icon--ulceraAverage", src "assets/imgs/bed.png" ]
                    []
                , span []
                    [ text "Risco Médio" ]
                ]
            , div []
                [ img [ class "image__icon image__icon--ulceraHigh", src "assets/imgs/bed.png" ]
                    []
                , span []
                    [ text "Risco Alto" ]
                ]
            ]
        ]


header : String -> String -> String -> a -> Html a
header title date version action =
    div
        [ class "header__wrapper"
        ]
        [ div [ class "logo__wrapper" ]
            [ img
                [ src "assets/imgs/logo.png", onClick action ]
                []
            ]
        , div [ class "title__wrapper" ]
            [ div
                [ class "title__wrapper--inner" ]
                [ text title ]
            , div
                [ class "title__version" ]
                [ text version ]
            ]
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
        , columnH "PACIENTE" "paciente"
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
        , columnHC "ALERGIAS" "alergiaASA"
          --, columnHC "EXAMES" "exameASA"
        , columnHC "CIRURGIAS" "cirurgia"
          -- , columnHC "JEJUM" "jejum"
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
                Ocupado ->
                    ( "man-user.png", "ocupada" )

                AltaMedica ->
                    ( "man-user.png", "alta" )

                Vago ->
                    ( "hotel-single-bed.png", "vago" )

                Acompanhante ->
                    ( "man-user.png", "acompanhante" )

                Limpeza ->
                    ( "wiping-swipe-for-floors.png", "higienizacao" )

                Reservado ->
                    ( "hotel-door-key.png", "reservada" )

                Manutencao ->
                    ( "handyman-tools.png", "manutencao" )

                Interditado ->
                    ( "close-sign-for-door.png", "interditado" )

                Vazio ->
                    ( "cancel.png", "empty" )
    in
        img [ src ("assets/imgs/" ++ image), class ("image__icon image__icon--" ++ classR) ] []


precaucaoToHtml : CautionLevel -> Html a
precaucaoToHtml status =
    let
        ( image, classR ) =
            case status of
                Default ->
                    ( "hand.png", "precaucao--padrao" )

                Preventive ->
                    ( "hand.png", "precaucao--preventiva" )

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
                [ Svg.rect
                    [ SvgAtt.width "40"
                    , SvgAtt.height "40"
                    , SvgAtt.fill "orange"
                    ]
                    []
                ]

        Average ->
            Svg.svg [ SvgAtt.height "40", SvgAtt.width "40" ]
                [ Svg.circle
                    [ SvgAtt.cx "20"
                    , SvgAtt.cy "20"
                    , SvgAtt.r "20"
                    , SvgAtt.fill "#cc0099"
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


riscoQuedaToHtml : RiskLevel -> Html a
riscoQuedaToHtml risk =
    let
        riskClass =
            case risk of
                Low ->
                    "riscoQuedaLow"

                Average ->
                    "riscoQuedaAverage"

                High ->
                    "riscoQuedaLow"

                _ ->
                    ""

        result =
            if riskClass == "" then
                text ""
            else
                img [ src "assets/imgs/slide.png", class ("image__icon image__icon--" ++ riskClass) ] []
    in
        result


ulceraToHtml : RiskLevel -> Html a
ulceraToHtml risk =
    let
        riskClass =
            case risk of
                Low ->
                    "ulceraLow"

                Average ->
                    "ulceraAverage"

                High ->
                    "ulceraHigh"

                _ ->
                    ""

        result =
            if riskClass == "" then
                text ""
            else
                img [ src "assets/imgs/bed.png", class ("image__icon image__icon--" ++ riskClass) ] []
    in
        result


stringItemToHtml : String -> Html a
stringItemToHtml s =
    div [ class "list__item__painel" ]
        [ div [ class "list__item__painel__inner" ] [ text s ] ]


stringListToHtml : List String -> String -> Html a
stringListToHtml l classR =
    let
        items =
            List.map stringItemToHtml l

        content =
            if (List.length items == 0) then
                text ""
            else
                div [ class ("list__painel list__painel--" ++ classR) ] items
    in
        content


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

        paciente =
            case room.paciente of
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
                Just s ->
                    s

                Nothing ->
                    "-"

        observacao =
            case room.observacao of
                Just s ->
                    s

                Nothing ->
                    ""

        previsao =
            case room.previsao of
                Just s ->
                    s

                _ ->
                    ""

        precaucao =
            case room.precaucao of
                Just p ->
                    precaucaoToHtml p

                Nothing ->
                    text ""

        scp =
            case room.scp of
                Just p ->
                    scpToHtml p

                Nothing ->
                    text ""

        riscoQueda =
            case room.riscoQueda of
                Just risk ->
                    riscoQuedaToHtml risk

                Nothing ->
                    text ""

        ulceraPressao =
            case room.ulceraPressao of
                Just ulcera ->
                    ulceraToHtml ulcera

                Nothing ->
                    text ""

        alergias =
            stringListToHtml room.alergias "alergias"

        --exames =
        --    stringListToHtml room.exames "exames"
        cirurgias =
            stringListToHtml room.cirurgias "cirurgias"

        jejum =
            case room.jejum of
                Just d ->
                    d

                Nothing ->
                    ""

        previsaoClass =
            if room.previsaoToday then
                "previsao--alerta"
            else
                "previsao"
    in
        div [ class rowClass, style [ ( "top", top ) ] ]
            [ columnTextPadding room.apto "apto"
            , columnHtml (roomStatusToHtml room.status) "status"
            , columnTextPadding paciente "paciente"
            , columnTextPadding medico "medico"
            , columnTextPadding convenio "convenio"
            , columnTextPadding observacao "observacao"
            , columnTextCenter previsao previsaoClass
            , columnHtml precaucao "precaucao"
            , columnHtml scp "scp"
            , columnHtml riscoQueda "riscoQueda"
            , columnHtml ulceraPressao "ulceraPressao"
            , columnHtml alergias "alergiaASA"
              --, columnHtml exames "examesASA"
            , columnHtml cirurgias "cirurgias"
              -- , columnTextCenter jejum "jejum"
            ]


roomsToHtml : List Room -> Html a
roomsToHtml rooms =
    div [ class "rows__wrapper" ]
        (List.map
            roomToHtml
            rooms
        )
