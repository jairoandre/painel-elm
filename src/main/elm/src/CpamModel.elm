module CpamModel exposing (..)

import Json.Decode exposing (Decoder, int, string, float, bool, list, null, oneOf)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)


type alias CpamJson =
    { date : String
    , version : String
    , setores : List SetorCpamJson
    , setorCount : Int
    }


cpamJsonDecoder : Decoder CpamJson
cpamJsonDecoder =
    decode CpamJson
        |> required "date" string
        |> required "version" string
        |> required "setores" (list setorCpamJsonDecoder)
        |> optional "setorCount" int 0


emptySetorCpam : SetorCpamJson
emptySetorCpam =
    SetorCpamJson "" [] 0


type alias SetorCpamJson =
    { nome : String
    , pacientes : List PacienteCpamJson
    , pageCount : Int
    }


setorCpamJsonDecoder : Decoder SetorCpamJson
setorCpamJsonDecoder =
    decode SetorCpamJson
        |> required "nome" string
        |> required "pacientes" (list pacienteCpamJsonDecoder)
        |> optional "pageCount" int 0


type alias PacienteCpamJson =
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


pacienteCpamJsonDecoder : Decoder PacienteCpamJson
pacienteCpamJsonDecoder =
    decode PacienteCpamJson
        |> required "apto" string
        |> required "atendimento" int
        |> required "nome" string
        |> optional "altaMedica" string ""
        |> optional "altaHospitalar" string ""
        |> optional "suspensos" (list string) []
        |> optional "agora" (list string) []
        |> optional "urgente" (list string) []
        |> optional "alergias" (list string) []
