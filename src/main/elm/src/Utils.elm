module Utils exposing (..)

import Time exposing (Time, minute, second)
import Date exposing (Date)


timeToStr : Time -> String
timeToStr originTime =
    let
        time =
            originTime + 7200000

        -- HACK PARA TV
        date =
            Date.fromTime time

        day =
            Date.day date

        dayStr =
            if day < 10 then
                "0" ++ toString day
            else
                toString day

        monthStr =
            case (Date.month date) of
                Date.Jan ->
                    "01"

                Date.Feb ->
                    "02"

                Date.Mar ->
                    "03"

                Date.Apr ->
                    "04"

                Date.May ->
                    "05"

                Date.Jun ->
                    "06"

                Date.Jul ->
                    "07"

                Date.Aug ->
                    "08"

                Date.Sep ->
                    "09"

                Date.Oct ->
                    "10"

                Date.Nov ->
                    "11"

                Date.Dec ->
                    "12"

        yearStr =
            toString <| Date.year <| date

        hour =
            Date.hour date

        minute =
            Date.minute date

        second =
            Date.second date

        hourStr =
            if hour < 10 then
                "0" ++ toString hour
            else
                toString hour

        minuteStr =
            if minute < 10 then
                "0" ++ toString minute
            else
                toString minute

        secondStr =
            if second < 10 then
                "0" ++ toString second
            else
                toString second
    in
        dayStr ++ "/" ++ monthStr ++ "/" ++ yearStr



-- ++ " " ++ hourStr ++ ":" ++ minuteStr ++ ":" ++ secondStr
