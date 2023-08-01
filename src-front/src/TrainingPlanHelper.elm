module TrainingPlanHelper exposing (..)

import Duration exposing (..)
import List.Extra as LE exposing (..)
import TrainingPlan exposing (..)
import UtilsHelper exposing (..)


formatExerciseLocation : ExerciseLocation -> String
formatExerciseLocation exo =
    case exo of
        NoWater ->
            "Au sec"

        SwimmingPool25m ->
            "Bassin de 25m"

        SwimmingPool50m ->
            "Bassin de 50"

        SmallPool ->
            "Petit bain"

        DeepPool ->
            "Bassin profond / milieu naturel"


formatExerciseFamily : ExerciseFamily -> String
formatExerciseFamily exo =
    case exo of
        Unknown ->
            "❓"

        Break ->
            "☕"

        Duration ->
            "⏰"

        Distance ->
            "↔"

        Depth ->
            "↕"

        Relaxation ->
            "🌅"

        Composite ->
            "🎮"


formatExerciseCategory : ExerciseCategory -> String
formatExerciseCategory exo =
    case exo of
        Custom ->
            "Personalisé"

        Rest ->
            "Repos"

        Dry ->
            "Au sec"

        Breath ->
            "Respiration"

        Swim ->
            "Nage"

        DNF ->
            "DNF"

        DYN ->
            "DYN"

        STA ->
            "STA"

        CNF ->
            "CNF"

        CWT ->
            "CWT"

        FIM ->
            "FIM"

        VWT ->
            "VWT"

removeTrainingPlanPart : TrainingPlan -> TrainingPlanPart -> TrainingPlan
removeTrainingPlanPart plan part =
    { plan | parts = (LE.remove part plan.parts) }

removeExercise : TrainingPlanPart -> TrainingPlanExercise -> TrainingPlanPart
removeExercise part exo =
    { part | exercises = (LE.remove exo part.exercises) }

removeExerciseSubPart : TrainingPlanExercise -> TrainingPlanExerciseSubPart -> TrainingPlanExercise
removeExerciseSubPart exo part_to_del =
    { exo | parts = (LE.remove part_to_del exo.parts) }

createDefaultTrainingPlan : String -> String -> String -> TrainingPlan
createDefaultTrainingPlan name author group =
    TrainingPlan name
        author
        ""
        group
        [ TrainingPlanPart "Briefing"
            NoWater
            [ TrainingPlanExercise Break
                "Session explanations"
                ""
                1
                [ TrainingPlanExerciseSubPart Rest 0 0 (createDurationFromMin 0) (createDurationFromMin 5) ]
            ]
        , TrainingPlanPart "Échauffement"
            SwimmingPool25m
            [ TrainingPlanExercise Distance
                "400m nage"
                ""
                1
                [ TrainingPlanExerciseSubPart Swim 400 0 (createDurationFromMin 10) (createDurationFromSec 0) ]
            , TrainingPlanExercise Distance
                "10minutes nage"
                ""
                1
                [ TrainingPlanExerciseSubPart Swim 0 0 (createDurationFromMin 10) (createDurationFromSec 0) ]
            , TrainingPlanExercise Break
                "Récup"
                ""
                1
                [ TrainingPlanExerciseSubPart Rest 0 0 (createDurationFromSec 0) (createDurationFromMin 2) ]
            , TrainingPlanExercise Distance
                "Tranquille"
                ""
                4
                [ TrainingPlanExerciseSubPart DYN 25 0 (createDurationFromSec 30) (createDurationFromSec 30) ]
            , TrainingPlanExercise Break
                "Récup"
                ""
                1
                [ TrainingPlanExerciseSubPart Rest 0 0 (createDurationFromSec 0) (createDurationFromMin 2) ]
            ]
        , TrainingPlanPart "Corps de l’entrainement"
            SwimmingPool25m
            [ TrainingPlanExercise Distance
                "First 16x25"
                ""
                16
                [ TrainingPlanExerciseSubPart DYN 25 0 (createDurationFromSec 30) (createDurationFromSec 30) ]
            , TrainingPlanExercise Break "Récup" "" 1 [ TrainingPlanExerciseSubPart Rest 0 0 (createDurationFromSec 0) (createDurationFromMin 2) ]
            , TrainingPlanExercise Composite
                "Stop dyn stop"
                ""
                4
                [ TrainingPlanExerciseSubPart STA 0 0 (createDurationFromSec 30) (createDurationFromSec 0)
                , TrainingPlanExerciseSubPart DYN 25 0 (createDurationFromSec 30) (createDurationFromSec 0)
                , TrainingPlanExerciseSubPart STA 0 0 (createDurationFromSec 30) (createDurationFromSec 0)
                , TrainingPlanExerciseSubPart Rest 0 0 (createDurationFromSec 0) (createDurationFromSec 30)
                ]
            , TrainingPlanExercise Break "Récup" "" 1 [ TrainingPlanExerciseSubPart Rest 0 0 (createDurationFromSec 0) (createDurationFromMin 2) ]
            , TrainingPlanExercise Distance
                "4x50 départ 2min"
                ""
                4
                [ TrainingPlanExerciseSubPart DYN 50 0 (createDurationFromMin 1) (createDurationFromSec 50) ]
            , TrainingPlanExercise Break
                "Récup"
                ""
                1
                [ TrainingPlanExerciseSubPart Rest 0 0 (createDurationFromSec 0) (createDurationFromMin 5) ]
            ]
        , TrainingPlanPart "Récupération"
            SwimmingPool25m
            [ TrainingPlanExercise Break
                "Récup"
                ""
                1
                [ TrainingPlanExerciseSubPart Rest 0 0 (createDurationFromSec 0) (createDurationFromMin 1) ]
            , TrainingPlanExercise Distance
                "200m detente"
                ""
                1
                [ TrainingPlanExerciseSubPart DYN 200 0 (createDurationFromMin 3) (createDurationFromMin 2) ]
            ]
        , TrainingPlanPart "Debriefing"
            NoWater
            [ TrainingPlanExercise Break
                "Session debrief"
                ""
                1
                [ TrainingPlanExerciseSubPart Rest 0 0 (createDurationFromMin 0) (createDurationFromMin 3) ]
            ]
        ]
