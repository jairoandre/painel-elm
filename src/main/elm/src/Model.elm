module Model exposing (..)

import Json.Decode exposing (Decoder, int, string, float, bool, list, null, oneOf)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)


type alias Room =
    { apto : String
    , status : RoomStatus
    , paciente : Maybe String
    , medico : Maybe String
    , convenio : Maybe String
    , observacao : Maybe String
    , previsao : Maybe String
    , previsaoToday : Bool
    , precaucao : Maybe CautionLevel
    , scp : Maybe RiskLevel
    , riscoQueda : Maybe RiskLevel
    , ulceraPressao : Maybe RiskLevel
    , alergias : List String
    , exames : List String
    , cirurgias : List String
    , jejum : Maybe String
    , altaMedica : Bool
    }


type alias RoomJson =
    { apto : String
    , status : Int
    , paciente : String
    , medico : String
    , convenio : String
    , observacao : String
    , previsao : String
    , previsaoToday : Bool
    , precaucao : Int
    , scp : Int
    , riscoQueda : Int
    , ulceraPressao : Int
    , alergias : List String
    , exames : List String
    , cirurgias : List String
    , jejum : String
    , altaMedica : Bool
    }


type alias Painel =
    { date : String
    , rooms : List Room
    , version : String
    }


type alias PainelJson =
    { date : String
    , rooms : List RoomJson
    , version : String
    }


roomJsonDecoder : Decoder RoomJson
roomJsonDecoder =
    decode RoomJson
        |> required "apto" string
        |> required "status" int
        |> optional "paciente" string ""
        |> optional "medico" string ""
        |> optional "convenio" string ""
        |> optional "observacao" string ""
        |> optional "previsao" string ""
        |> optional "previsaoToday" bool False
        |> optional "precaucao" int -1
        |> optional "scp" int -1
        |> optional "riscoQueda" int -1
        |> optional "ulceraPressao" int -1
        |> optional "alergias" (list string) []
        |> optional "exames" (list string) []
        |> optional "cirurgias" (list string) []
        |> optional "jejum" string ""
        |> optional "altaMedica" bool False


roomsJsonDecoder : Decoder (List RoomJson)
roomsJsonDecoder =
    list roomJsonDecoder


painelJsonDecoder : Decoder PainelJson
painelJsonDecoder =
    decode PainelJson
        |> required "date" string
        |> required "rooms" roomsJsonDecoder
        |> required "version" string


appendIdx : Int -> String -> String
appendIdx idx s =
    (toString (idx + 1)) ++ " - " ++ s


roomJsonToModel : RoomJson -> Room
roomJsonToModel json =
    let
        apto =
            json.apto

        status =
            case json.status of
                0 ->
                    Ocupado

                1 ->
                    AltaMedica

                2 ->
                    Vago

                3 ->
                    Acompanhante

                4 ->
                    Limpeza

                5 ->
                    Reservado

                6 ->
                    Manutencao

                7 ->
                    Interditado

                _ ->
                    Vazio

        paciente =
            Just json.paciente

        medico =
            Just json.medico

        convenio =
            Just json.convenio

        observacao =
            Just json.observacao

        previsao =
            Just json.previsao

        precaucao =
            case json.precaucao of
                6 ->
                    Just Default

                7 ->
                    Just Preventive

                1 ->
                    Just Aerosols

                2 ->
                    Just Contact

                3 ->
                    Just ContactAerosols

                4 ->
                    Just ContactDroplets

                5 ->
                    Just Droplets

                _ ->
                    Nothing

        scp =
            case json.scp of
                0 ->
                    Just VeryLow

                1 ->
                    Just Low

                2 ->
                    Just Average

                3 ->
                    Just High

                4 ->
                    Just NoRisk

                _ ->
                    Nothing

        riscoQueda =
            case json.riscoQueda of
                0 ->
                    Just Low

                1 ->
                    Just Average

                2 ->
                    Just High

                _ ->
                    Nothing

        ulceraPressao =
            case json.ulceraPressao of
                0 ->
                    Just Low

                1 ->
                    Just Average

                2 ->
                    Just High

                _ ->
                    Nothing

        alergias =
            List.indexedMap appendIdx json.alergias

        exames =
            List.indexedMap appendIdx json.exames

        cirurgias =
            List.indexedMap appendIdx json.cirurgias

        jejum =
            case json.jejum of
                "" ->
                    Nothing

                _ ->
                    Just json.jejum
    in
        Room
            apto
            status
            paciente
            medico
            convenio
            observacao
            previsao
            json.previsaoToday
            precaucao
            scp
            riscoQueda
            ulceraPressao
            alergias
            exames
            cirurgias
            jejum
            json.altaMedica


roomsJsonToModel : List RoomJson -> List Room
roomsJsonToModel roomsJson =
    List.map roomJsonToModel roomsJson


painelJsonToModel : PainelJson -> Painel
painelJsonToModel painelJson =
    Painel painelJson.date (roomsJsonToModel painelJson.rooms) painelJson.version


type RoomStatus
    = Ocupado
    | AltaMedica
    | Vago
    | Acompanhante
    | Limpeza
    | Reservado
    | Manutencao
    | Interditado
    | Vazio


type CautionLevel
    = Default
    | Preventive
    | Aerosols
    | Contact
    | ContactAerosols
    | ContactDroplets
    | Droplets
    | NoCaution


type RiskLevel
    = NoRisk
    | VeryLow
    | Low
    | Average
    | High
