module TrainingPlanHelper exposing (..)

import TrainingPlan exposing(..)
import Duration exposing(..)

type Msg
  = Name String


formatDistance: Int -> String
formatDistance dist=
    (String.fromInt dist) ++ "m"

formatExerciseLocation: ExerciseLocation -> String
formatExerciseLocation exo=
  case exo of
    NoWater -> "Au sec"
    SwimmingPool25m -> "Bassin de 25m"
    SwimmingPool50m -> "Bassin de 50"
    SmallPool -> "Petit bain"
    DeepPool -> "Bassin profond / milieu naturel"


formatExerciseFamily: ExerciseFamily -> String
formatExerciseFamily exo=
  case exo of
    Unknown -> "Autre"
    Break -> "Repos"
    Duration -> "Durée"
    Distance -> "Distance"
    Depth -> "Profondeur"
    Relaxation -> "Relaxation"
    Composite -> "Composite"

formatExerciseCategory: ExerciseCategory -> String
formatExerciseCategory exo=
  case exo of
    Custom -> "Personalisé"
    Rest -> "Repos"
    Dry -> "Au sec"
    Breath -> "Respiration"
    Swim -> "Nage"
    DNF -> "Dynamique SANS palme"
    DYN -> "Dynamique"
    STA  -> "Statique"
    CNF -> "Poids constant SANS palme"
    CWT -> "Poids constant"
    FIM -> "Immersion libre"
    VWT -> "Poids variable"
  
createDefaultTrainingPlan: String -> String -> String -> TrainingPlan
createDefaultTrainingPlan name author group=
  TrainingPlan name author "" group [
    TrainingPlanPart "Briefing" NoWater [
      TrainingPlanExercise Break "Session explanations" "" 1 
        [TrainingPlanExerciseSubPart Rest 0 0 (createDurationFromMin 0) (createDurationFromMin 5) ]
    ]

    ,TrainingPlanPart "Échauffement" SwimmingPool25m [ 
      TrainingPlanExercise Distance "400m nage" "" 1 
        [TrainingPlanExerciseSubPart Swim 400 0 (createDurationFromMin 10) (createDurationFromSec 0)]
      
      , TrainingPlanExercise Break "Récup" "" 1 
        [TrainingPlanExerciseSubPart Rest 0 0 (createDurationFromSec 0) (createDurationFromMin 2)]
      
      ,TrainingPlanExercise Distance "Tranquille" "" 4 
        [TrainingPlanExerciseSubPart DYN 25 0 (createDurationFromSec 30) (createDurationFromSec 30)]
      
      , TrainingPlanExercise Break "Récup" "" 1 
        [TrainingPlanExerciseSubPart Rest 0 0 (createDurationFromSec 0) (createDurationFromMin 2)]
    ]

    ,TrainingPlanPart "Corps de l’entrainement" SwimmingPool25m [
      TrainingPlanExercise Distance "First 16x25" "" 16 
        [TrainingPlanExerciseSubPart DYN 25 0 (createDurationFromSec 30) (createDurationFromSec 30)]

      , TrainingPlanExercise Break "Récup" "" 1 
        [TrainingPlanExerciseSubPart Rest 0 0 (createDurationFromSec 0) (createDurationFromMin 2)]

      , TrainingPlanExercise Distance "4x50 départ 2min" "" 4 
        [TrainingPlanExerciseSubPart DYN 50 0 (createDurationFromMin 1) (createDurationFromSec 50)]
      
      , TrainingPlanExercise Break "Récup" "" 1 
        [TrainingPlanExerciseSubPart Rest 0 0 (createDurationFromSec 0) (createDurationFromMin 5)]
    ]

    ,TrainingPlanPart "Récupération" SwimmingPool25m [
      TrainingPlanExercise Distance "4x25m lent" "" 4 
        [TrainingPlanExerciseSubPart DYN 25 0 (createDurationFromSec 45) (createDurationFromSec 60)]

      , TrainingPlanExercise Break "Récup" "" 1 
        [TrainingPlanExerciseSubPart Rest 0 0 (createDurationFromSec 0) (createDurationFromMin 1)]

      , TrainingPlanExercise Distance "200m detente" "" 1 
        [TrainingPlanExerciseSubPart DYN 200 0 (createDurationFromMin 3) (createDurationFromMin 2)]
    ]

    ,TrainingPlanPart "Debriefing" NoWater [
      TrainingPlanExercise Break "Session debrief" "" 1 
        [TrainingPlanExerciseSubPart Rest 0 0 (createDurationFromMin 0) (createDurationFromMin 3) ]
    ]
  ]

