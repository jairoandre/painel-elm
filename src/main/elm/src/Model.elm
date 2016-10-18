module Model exposing (..)

import Json.Decode exposing (Decoder, int, string, float, list, null, oneOf)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)
import Random


type alias Room =
    { apto : String
    , status : RoomStatus
    , paciente : Maybe String
    , medico : Maybe String
    , convenio : Maybe String
    , observacao : Maybe String
    , previsao : Maybe String
    , precaucao : Maybe CautionLevel
    , scp : Maybe RiskLevel
    , riscoQueda : Maybe RiskLevel
    , ulceraPressao : Maybe RiskLevel
    , alergias : List String
    , exames : List String
    , cirurgia : Maybe String
    , jejum : Maybe String
    , idx : Int
    }


type alias RoomJson =
    { apto : String
    , status : Int
    , paciente : String
    , medico : String
    , convenio : String
    , observacao : String
    , previsao : String
    , caution : Int
    , scp : Int
    , fallRisk : Int
    , pressureUlcer : Int
    , allergies : String
    , exams : String
    , surgery : String
    , fasting : String
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
        |> optional "prediction" string ""
        |> optional "caution" int -1
        |> optional "scp" int -1
        |> optional "fallRisk" int -1
        |> optional "pressureUlcer" int -1
        |> optional "allergies" string ""
        |> optional "exams" string ""
        |> optional "surgery" string ""
        |> optional "fasting" string ""


type alias Company =
    { name : String
    , catchPhrase : String
    , bs : String
    }


companyDecoder : Decoder Company
companyDecoder =
    decode Company
        |> required "name" string
        |> required "catchPhrase" string
        |> required "bs" string


type alias UserJson =
    { id : Int
    , name : String
    , username : String
    , email : String
    , phone : String
    , website : String
    , company : Company
    }


userJsonDecoder : Decoder UserJson
userJsonDecoder =
    decode UserJson
        |> required "id" int
        |> required "name" string
        |> required "username" string
        |> required "email" string
        |> required "phone" string
        |> required "website" string
        |> required "company" companyDecoder


testJsonDecoder : Decoder (List UserJson)
testJsonDecoder =
    list userJsonDecoder


type RoomStatus
    = Occupied
    | MedicalRelease
    | Vacancy
    | Companion
    | Cleaning
    | Reserved
    | Maintenance
    | Interdicted
    | EmptyRoom


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


updateRoomIndex : Int -> Room -> Room
updateRoomIndex idx room =
    { room | idx = idx }
