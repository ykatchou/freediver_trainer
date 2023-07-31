module Duration exposing (..)

import TrainingPlan exposing(..)

createDurationFromSec: Int -> Timer
createDurationFromSec secs =
  let m = secs // 60
  in
    Timer m ( secs - (m*60) )

createDurationFromMin: Int -> Timer
createDurationFromMin m=
    Timer m 0

getsecondsFromDuration: Timer -> Int
getsecondsFromDuration dur=
  (dur.min*60)+dur.sec

concatDuration: List Timer -> Timer
concatDuration list_timer =
  createDurationFromSec (
    list_timer
      |> List.map getsecondsFromDuration
      |> List.sum
    )

calculateExerciseSubPartDuration: TrainingPlanExerciseSubPart -> Timer
calculateExerciseSubPartDuration subpart=
  concatDuration [subpart.duration, subpart.rest]

calculateTotalExerciseDuration: TrainingPlanExercise -> Timer
calculateTotalExerciseDuration exo=
  let 
    final_timer = 
      exo.parts
        |> List.map calculateExerciseSubPartDuration
        |> concatDuration
  in
    createDurationFromSec ((getsecondsFromDuration final_timer) * exo.repeat)

formatDuration: Timer -> String
formatDuration dur=
    if dur.min > 0 then
        if dur.sec > 0 then
            (String.fromInt dur.min) ++ "min " ++ (String.fromInt dur.sec) ++ "sec"
        else
            (String.fromInt dur.min) ++ "min "
    else
        (String.fromInt dur.sec) ++ "sec"