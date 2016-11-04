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
        [ columnH "LEITO" "apto--cpam"
        , columnH "ATEND." "atendimento--cpam"
        , columnH "PACIENTE" "paciente--cpam"
        , columnH "ALTA MÉD." "altaMedica--cpam"
        , columnH "ALTA HOSP." "altaHospitalar--cpam"
        , columnH "MED. SUSPENSOS" "suspensos--cpam"
        , columnH "MED. AGORA" "agora--cpam"
        , columnH "MED. URGENTE" "urgente--cpam"
        , columnH "ALERGIAS" "alergias--cpam"
        ]


cpamSetorToHtml : SetorCpamJson -> Html a
cpamSetorToHtml setorCpam =
    div [ class "rows__wrapper" ]
        (List.indexedMap
            cpamToHtml
            (List.take 20 (List.drop (setorCpam.pageCount * 20) setorCpam.pacientes))
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

        agora =
            stringListToHtml paciente.agora "agora--cpam"

        urgente =
            stringListToHtml paciente.urgente "urgente--cpam"

        alergias =
            stringListToHtml paciente.alergias "alergias--cpam"
    in
        div [ class rowClass, style [ ( "top", top ) ] ]
            [ columnTextPadding paciente.apto "apto--cpam"
            , columnTextPadding (toString paciente.atendimento) "atendimento--cpam"
            , columnTextPadding paciente.nome "paciente--cpam"
            , columnTextPadding paciente.altaMedica "altaMedica--cpam"
            , columnHtml altaHospitalar "altaHospitalar--cpam"
            , columnHtml suspensos "suspensos--cpam"
            , columnHtml agora "agora--cpam"
            , columnHtml urgente "urgente--cpam"
            , columnHtml alergias "alergias--cpam"
            ]
