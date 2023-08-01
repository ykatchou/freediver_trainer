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

calculateTrainingPlanPartDuration: TrainingPlanPart -> Timer
calculateTrainingPlanPartDuration exo=
  let 
    final_timer = 
      exo.exercises
        |> List.map calculateTotalExerciseDuration
        |> concatDuration
  in
    createDurationFromSec (getsecondsFromDuration final_timer)


calculateTrainingPlanDuration: TrainingPlan -> Timer
calculateTrainingPlanDuration exo=
  let 
    final_timer = 
      exo.parts
        |> List.map calculateTrainingPlanPartDuration
        |> concatDuration
  in
    createDurationFromSec (getsecondsFromDuration final_timer)
