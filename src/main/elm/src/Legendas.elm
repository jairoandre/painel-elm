module Legendas exposing (..)

import Html exposing (Html, div, h3, span, text, img)
import Html.Attributes exposing (..)
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
                    [ text "Cuidados Semi Intensivos" ]
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
                [ text "LESÃO POR PRESSÃO" ]
            , div []
                [ img [ class "image__icon image__icon--ulceraLow", src "assets/imgs/bed.png" ]
                    []
                , span []
                    [ text "Risco Mínimo" ]
                ]
            , div []
                [ img [ class "image__icon image__icon--ulceraAverage", src "assets/imgs/bed.png" ]
                    []
                , span []
                    [ text "Risco Moderado" ]
                ]
            , div []
                [ img [ class "image__icon image__icon--ulceraHigh", src "assets/imgs/bed.png" ]
                    []
                , span []
                    [ text "Risco Elevado" ]
                ]
            ]
        ]
