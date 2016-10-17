module Mock exposing (..)

import Model exposing (..)
import Random


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


genRiskLevel : Int -> Maybe RiskLevel
genRiskLevel newInt =
    case newInt of
        1 ->
            Just NoRisk

        2 ->
            Just VeryLow

        3 ->
            Just Low

        4 ->
            Just Average

        5 ->
            Just High

        _ ->
            Nothing


genCautionLevel : Int -> Maybe CautionLevel
genCautionLevel newInt =
    case newInt of
        1 ->
            Just Preventive

        2 ->
            Just Aerosols

        3 ->
            Just Contact

        4 ->
            Just ContactAerosols

        5 ->
            Just ContactDroplets

        6 ->
            Just Droplets

        7 ->
            Just NoCaution

        8 ->
            Just Default

        _ ->
            Nothing


randomStatusRoom : Int -> Random.Seed -> RoomStatus
randomStatusRoom idx seed =
    let
        ( roomStatus, newSeed ) =
            Random.step generateStatus seed
    in
        if idx == 0 then
            roomStatus
        else
            randomStatusRoom (idx - 1) newSeed


randomRisk : Int -> Random.Seed -> Maybe RiskLevel
randomRisk idx seed =
    let
        ( riskLevel, newSeed ) =
            Random.step generateRisk seed
    in
        if idx == 0 then
            riskLevel
        else
            randomRisk (idx - 1) newSeed


randomCaution : Int -> Random.Seed -> Maybe CautionLevel
randomCaution idx seed =
    let
        ( cautionLevel, newSeed ) =
            Random.step generateCaution seed
    in
        if idx == 0 then
            cautionLevel
        else
            randomCaution (idx - 1) newSeed


generateStatus : Random.Generator RoomStatus
generateStatus =
    Random.map genRoomStatus (Random.int 1 9)


generateRisk : Random.Generator (Maybe RiskLevel)
generateRisk =
    Random.map genRiskLevel (Random.int 1 6)


generateCaution : Random.Generator (Maybe CautionLevel)
generateCaution =
    Random.map genCautionLevel (Random.int 1 6)


mockRooms : List Room
mockRooms =
    let
        seed =
            Random.initialSeed 4992
    in
        List.indexedMap mockRoom (List.repeat 40 seed)


mockRoom : Int -> Random.Seed -> Room
mockRoom idx seed =
    Room
        "103/A"
        (randomStatusRoom idx seed)
        (Just ("Paciente Fulano Siclano " ++ (toString idx)))
        (Just ("Dr. Médico Beltrano " ++ (toString idx)))
        (Just ("Convênio Extenso " ++ (toString idx)))
        (Just ("Observação " ++ (toString idx)))
        (Just "01/01/2016")
        (randomCaution idx seed)
        (randomRisk (idx + 1) seed)
        (randomRisk (idx + 2) seed)
        (randomRisk (idx + 3) seed)
        Nothing
        -- ALERGIA
        Nothing
        -- EXAMES
        Nothing
        -- CIRURGIA
        (Just "lactose")
        -- DIETA
        idx
