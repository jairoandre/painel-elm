module Model exposing (Room, RoomJson, UserJson, testJsonDecoder, RoomStatus, CautionLevel, RiskLevel, mockRoom, mockRooms, roomJsonDecoder)

import Json.Decode exposing (Decoder, int, string, float, list, null, oneOf)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)
import Random


type alias Room =
    { apto : String
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
    , idx : Int
    }


type alias RoomJson =
    { apto : String
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
    , fasting : String
    }


roomJsonDecoder : Decoder RoomJson
roomJsonDecoder =
    decode RoomJson
        |> required "apto" string
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


genRoomStatus : Int -> RoomStatus
genRoomStatus newInt =
    case newInt of
        1 ->
            Occupied

        2 ->
            MedicalRelease

        3 ->
            Vacancy

        4 ->
            Companion

        5 ->
            Cleaning

        6 ->
            Reserved

        7 ->
            Maintenance

        8 ->
            Interdicted

        _ ->
            EmptyRoom


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


whataHell : Int -> Random.Seed -> RoomStatus
whataHell idx seed =
    let
        ( roomStatus, newSeed ) =
            Random.step generateStatus seed
    in
        if idx == 0 then
            roomStatus
        else
            whataHell (idx - 1) newSeed


mockRoom : Int -> Random.Seed -> Room
mockRoom idx seed =
    Room
        "103/A"
        (whataHell idx seed)
        (Just ("Paciente " ++ (toString idx)))
        (Just ("Médico " ++ (toString idx)))
        (Just ("Convênio " ++ (toString idx)))
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
        idx


generateStatus : Random.Generator RoomStatus
generateStatus =
    Random.map genRoomStatus (Random.int 1 9)


mockRooms : List Room
mockRooms =
    let
        seed =
            Random.initialSeed 4992
    in
        List.indexedMap mockRoom (List.repeat 20 seed)
