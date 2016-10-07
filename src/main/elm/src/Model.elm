module Model exposing (Room, RoomJson, UserJson, testJsonDecoder, RoomStatus, CautionLevel, RiskLevel, mockRoom, roomJsonDecoder)

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
  , allergies : List String
  , exams : List String
  , surgery : String
  , fasting : String
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
    |> optional "allergies" (list string) []
    |> optional "exams" (list string) []
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

stringToRoomStatus : String -> RoomStatus
stringToRoomStatus status =
  case status of
    "Occupied" ->
      Occupied
    "MedicalRelease" ->
      MedicalRelease
    "Vacancy" ->
      Vacancy
    "Companion" ->
      Companion
    "Cleaning" ->
      Cleaning
    "Reserved" ->
      Reserved
    "Maintenance" ->
      Maintenance
    "Interdicted" ->
      Interdicted
    "EmptyRoom" ->
      EmptyRoom

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
    (Just "lactose")
