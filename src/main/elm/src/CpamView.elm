module CpamView exposing (..)

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (class, style)
import View exposing (columnH, columnHC)
import CpamModel exposing (..)
import View exposing (..)
import String


headerCpam : Html a
headerCpam =
    div
        [ class "column__header__wrapper" ]
        [ columnH "LEITO" "aptoCpam"
        , columnH "ATEND." "atendimentoCpam"
        , columnH "PACIENTE" "pacienteCpam"
        , columnH "ALTA MÉD." "altaMedicaCpam"
        , columnH "ALTA HOSP." "altaHospitalarCpam"
        , columnH "MÉD. SUSPENSOS" "suspensosCpam"
        , columnH "MÉD. AGORA" "agoraCpam"
        , columnH "MÉD. URGENTE" "urgenteCpam"
        , columnH "ALERGIAS" "alergiasCpam"
        ]


cpamSetorToHtml : SetorCpamJson -> Html a
cpamSetorToHtml setorCpam =
    div [ class "rows__wrapper" ]
        (List.indexedMap
            cpamToHtml
            (List.take 20 (List.drop setorCpam.pageCount setorCpam.pacientes))
        )


cpamToHtml : Int -> PacienteCpamJson -> Html a
cpamToHtml idx paciente =
    let
        top =
            (toString (50 * idx)) ++ "px"

        rowClass =
            if idx % 2 == 0 then
                "row__wrapper"
            else
                "row__wrapper row__wrapper--zebra"

        altaHospitalar =
            if (String.isEmpty paciente.altaHospitalar) then
                text ""
            else
                span [ class "span--altaHospitalar" ] [ text paciente.altaHospitalar ]

        suspensos =
            stringListToHtml paciente.suspensos "suspensos--cpam"
    in
        div [ class rowClass, style [ ( "top", top ) ] ]
            [ columnTextPadding paciente.apto "apto--cpam"
            , columnTextPadding (toString paciente.atendimento) "atendimento--cpam"
            , columnTextPadding paciente.nome "paciente--cpam"
            , columnTextPadding paciente.altaMedica "altaMedica--cpam"
            , columnHtml altaHospitalar "altaHospitalar--cpam"
            , columnHtml suspensos "suspensos--cpam"
            , stringListToHtml paciente.agora "agora--cpam"
            , stringListToHtml paciente.urgente "urgente--cpam"
            , stringListToHtml paciente.alergias "alergias--cpam"
            ]
