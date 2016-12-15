module View exposing (..)

import Html exposing (Html, div, ul, li, img, h2, h3, span, button, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Model exposing (..)
import Svg
import Svg.Attributes as SvgAtt


header : String -> String -> String -> Bool -> String -> a -> Html a
header title date version loading page action =
    let
        loadingClass =
            if loading then
                "loading--header"
            else
                "loading--header--hidden"
    in
        div
            [ class "header__wrapper"
            ]
            [ div [ class "logo__wrapper" ]
                [ img
                    [ src "assets/imgs/logo.png", onClick action ]
                    []
                , div
                    [ class "title__version" ]
                    [ text version ]
                ]
            , div [ class "title__wrapper" ]
                [ img
                    [ src "assets/imgs/loading.gif", class loadingClass ]
                    []
                , div
                    [ class "title__wrapper--inner" ]
                    [ text title ]
                , div
                    [ class "title__page" ]
                    [ text page ]
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
        , columnHC "LESÃO PRES." "ulcera"
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
                    "riscoQuedaHigh"

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


roomToHtml : Int -> Room -> Html a
roomToHtml idx room =
    let
        top =
            (toString (50 * idx)) ++ "px"

        rowClass =
            if idx % 2 == 0 then
                "row__wrapper"
            else
                "row__wrapper row__wrapper--zebra"

        rowClassAltaMedica =
            if room.altaMedica then
                " row__wrapper--bgaltaMedica"
            else
                ""

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

        previsaoHtml =
            if room.previsaoToday then
                span [ class "span--altaHospitalar" ] [ text previsao ]
            else
                span [] [ text previsao ]
    in
        div [ class (rowClass ++ rowClassAltaMedica), style [ ( "top", top ) ] ]
            [ columnTextPadding room.apto "apto"
            , columnHtml (roomStatusToHtml room.status) "status"
            , columnTextPadding paciente "paciente"
            , columnTextPadding medico "medico"
            , columnTextPadding convenio "convenio"
            , columnTextPadding observacao "observacao"
            , columnHtml previsaoHtml "previsao"
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
        (List.indexedMap
            roomToHtml
            rooms
        )
