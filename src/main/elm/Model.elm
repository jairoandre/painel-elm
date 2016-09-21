module Model exposing (Room, RoomJson, RoomStatus, CautionLevel, RiskLevel, mockRoom, roomJsonDecoder)

import Json.Decode exposing (Decoder, int, string, float, list, null, oneOf)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)

type alias Room =
  { name : String
  , status : RoomStatus
  , patient : Maybe String
  , physician : Maybe String
  , provider : Maybe String
  , observation : Maybe String
  , prediction : Maybe String
  , caution : CautionLevel
  , scp : RiskLevel
  , fallRisk : RiskLevel
  , pressureUlcer : RiskLevel
  , allergies : Maybe (List String)
  , exams : Maybe (List String)
  , surgery : Maybe String
  , fasting : Maybe String
  }

type alias RoomJson =
  { name : String
  , status : Int
  , patient : String
  , physician : String
  , provider : String
  , observation : String
  , prediction : String
  , caution : Int
  , scp : Int
  , fallRisk : Int
  , pressureUlcer : Int
  , allergies : String
  , exams : String
  , surgery : String
  , fasting : List String
  }

roomJsonDecoder : Decoder RoomJson
roomJsonDecoder =
  decode RoomJson
    |> required "name" string
    |> required "status" int
    |> optional "patient" string ""
    |> optional "physician" string ""
    |> optional "provider" string ""
    |> optional "observation" string ""
    |> optional "prediction" string ""
    |> optional "caution" int -1
    |> optional "scp" int -1
    |> optional "fallRisk" int -1
    |> optional "pressureUlcer" int -1
    |> optional "allergies" string ""
    |> optional "exams" string ""
    |> optional "surgery" string ""
    |> optional "fasting" (list string)

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

roomJsonToObject : RoomJson -> Room
roomJsonToObject json =
  mockRoom

mockRoom : Room
mockRoom =
  Room
    "103/A"
    Occupied
    (Just "Pedro Molina")
    (Just "Dr. Alberto")
    (Just "Bradesco")
    Nothing
    (Just "01/01/2016")
    Preventive
    Low
    Average
    Low
    Nothing
    Nothing
    Nothing
    Nothing
