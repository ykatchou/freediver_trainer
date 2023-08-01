module UtilsHelper exposing (..)

import TrainingPlan exposing (Timer)

formatIfValueStr : String -> String -> String -> String
formatIfValueStr spre rep spos =
    if String.length rep > 0 then
        spre ++ rep ++ spos

    else
        ""


formatIfValue : String -> Int -> String -> String
formatIfValue spre rep spos =
    if rep > 1 then
        spre ++ String.fromInt rep ++ spos
    else
        ""


formatDistance : Int -> String
formatDistance dist =
    formatIfValue "" dist "m"


formatDuration: Timer -> String
formatDuration dur=
    if dur.min > 0 then
        if dur.sec > 0 then
            (String.fromInt dur.min) ++ "min " ++ (String.fromInt dur.sec) ++ "sec"
        else
            (String.fromInt dur.min) ++ "min"
    else
        if dur.sec > 0 then
            (String.fromInt dur.sec) ++ "sec"
        else
            ""

