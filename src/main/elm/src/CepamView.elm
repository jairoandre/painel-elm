module CepamView exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (class, style)
import View exposing (columnH, columnHC)
import CepamModel exposing (..)
import View exposing (..)


headerCepam : Html a
headerCepam =
    div
        [ class "column__header__wrapper" ]
        [ columnH "LEITO" "aptoCepam"
        , columnH "ATEND." "atendimentoCepam"
        , columnH "PACIENTE" "pacienteCepam"
        , columnH "ALTA MÉD." "altaMedicaCepam"
        , columnH "ALTA HOSP." "altaHospitalarCepam"
        , columnH "MÉD. SUSPENSOS" "suspensosCepam"
        , columnH "MÉD. AGORA" "agoraCepam"
        , columnH "MÉD. URGENTE" "urgenteCepam"
        , columnH "ALERGIAS" "alergiasCepam"
        ]


cepamSetorToHtml : SetorCepamJson -> Html a
cepamSetorToHtml setorCepam =
    div [ class "rows__wrapper" ]
        (List.indexedMap
            cepamToHtml
            (List.take 20 (List.drop setorCepam.pageCount setorCepam.pacientes))
        )


cepamToHtml : Int -> PacienteCepamJson -> Html a
cepamToHtml idx paciente =
    let
        top =
            (toString (50 * idx)) ++ "px"

        rowClass =
            if idx % 2 == 0 then
                "row__wrapper"
            else
                "row__wrapper row__wrapper--zebra"
    in
        div [ class rowClass, style [ ( "top", top ) ] ]
            [ columnTextPadding paciente.apto "apto--cepam"
            , columnTextPadding (toString paciente.atendimento) "atendimento--cepam"
            , columnTextPadding paciente.nome "paciente--cepam"
            , columnTextPadding paciente.altaMedica "altaMedica--cepam"
            , columnTextPadding paciente.altaHospitalar "altaHospitalar--cepam"
            , stringListToHtml paciente.suspensos "suspensos--cepam"
            , stringListToHtml paciente.agora "agora--cepam"
            , stringListToHtml paciente.urgente "urgente--cepam"
            , stringListToHtml paciente.alergias "alergias--cepam"
            ]
