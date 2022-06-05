module TrainingPlanHelper exposing (..)

import TrainingPlan exposing(..)
import Duration exposing(..)

type Msg
  = Name String


formatDistance: Int -> String
formatDistance dist=
    (String.fromInt dist) ++ "m"


calculateTotalPartDuration: TrainingPlanPart -> Duration
calculateTotalPartDuration part=
  createDurationFromSec (
    List.sum (
      List.map getsecondsFromDuration (
        List.map calculateTotalExerciseDuration part.exercises
      )
    )
  )

createDefaultTrainingPlan: String -> String -> String -> TrainingPlan
createDefaultTrainingPlan name author group=
  TrainingPlan name author "" group [
    TrainingPlanPart "Briefing" NoWater [
      TrainingPlanExercise Unknown "Session explanations" 0
      , TrainingPlanExercise 
          (Squarred
            (SquarredExercise
              (createDurationFromSec 15)
              (createDurationFromSec 15)
              (createDurationFromSec 15)
              (createDurationFromSec 15)
            ))
         "Squarred" 4
    ]

    ,TrainingPlanPart "Corpus" SwimmingPool25m [
      TrainingPlanExercise (DYN (DistanceExercise 25 (createDurationFromSec 30) (createDurationFromSec 30))) "First 16x25" 16
      , TrainingPlanExercise(Rest (RestExercise (createDurationFromMin 2))) "" 1
      ,TrainingPlanExercise (DYN (DistanceExercise 50 (createDurationFromSec 60) (createDurationFromSec 45))) "Second DYN" 1
    ]

    ,TrainingPlanPart "Debriefing" NoWater [
      TrainingPlanExercise (Rest (RestExercise (createDurationFromMin 5))) "Session debrief" 1
    ]
  ]

