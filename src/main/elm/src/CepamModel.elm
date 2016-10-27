module CepamModel exposing (..)

import Json.Decode exposing (Decoder, int, string, float, bool, list, null, oneOf)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)


type alias CepamJson =
    { date : String
    , version : String
    , setores : List SetorCepamJson
    , setorCount : Int
    }


cepamJsonDecoder : Decoder CepamJson
cepamJsonDecoder =
    decode CepamJson
        |> required "date" string
        |> required "version" string
        |> required "setores" (list setorCepamJsonDecoder)
        |> optional "setorCount" int 0


emptySetorCepam : SetorCepamJson
emptySetorCepam =
    SetorCepamJson "" [] 0


type alias SetorCepamJson =
    { nome : String
    , pacientes : List PacienteCepamJson
    , pageCount : Int
    }


setorCepamJsonDecoder : Decoder SetorCepamJson
setorCepamJsonDecoder =
    decode SetorCepamJson
        |> required "nome" string
        |> required "pacientes" (list pacienteCepamJsonDecoder)
        |> optional "pageCount" int 0


type alias PacienteCepamJson =
    { apto : String
    , atendimento : Int
    , nome : String
    , altaMedica : String
    , altaHospitalar : String
    , suspensos : List String
    , agora : List String
    , urgente : List String
    , alergias : List String
    }


pacienteCepamJsonDecoder : Decoder PacienteCepamJson
pacienteCepamJsonDecoder =
    decode PacienteCepamJson
        |> required "apto" string
        |> required "atendimento" int
        |> required "nome" string
        |> optional "altaMedica" string ""
        |> optional "altaHospitalar" string ""
        |> optional "suspensos" (list string) []
        |> optional "agora" (list string) []
        |> optional "urgente" (list string) []
        |> optional "alergias" (list string) []
