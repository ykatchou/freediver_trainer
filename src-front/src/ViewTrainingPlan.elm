module ViewTrainingPlan exposing (..)

import Duration exposing (..)
import Element exposing (Element, alignRight, centerY, column, el, fill, padding, paragraph, rgb255, row, spacing, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import TrainingPlan exposing (..)
import TrainingPlanHelper exposing (..)
import ViewExercise exposing (..)


viewTrainingPlan : TrainingPlan -> Element Msg
viewTrainingPlan plan =
    column
        [ Background.color (rgb255 0 0 230)
        , Font.color (rgb255 0 0 0)
        , Border.rounded 3
        , padding 20
        ]
        [
        row [padding 10]
            [ el [] (text ("Entrainement :" ++ plan.name))
            , el [] (text ("Groupe : " ++ plan.group))
            , el [] (text ("Moniteur : " ++ plan.author))
            ]
        ,
        -- Training plan part style 
        column [
            Border.width 2
            , Border.rounded 4
            , Border.color (rgb255 255 255 255)
        ] (List.map viewTrainingPlanPart plan.parts)
        ]


viewTrainingPlanPart : TrainingPlanPart -> Element Msg
viewTrainingPlanPart part =
    column
        [ Background.color (rgb255 240 0 0)
        , Font.color (rgb255 255 255 255)
        , Border.color (rgb255 255 255 255)
        , Border.width 2
        , Border.rounded 3
        , padding 10
        ]
        [
        row []
        [
            el [] (text part.name)
            , el [] (text (formatExerciseLocation part.location))
            , el []
                (text
                    ("Durée totale : "
                        ++ formatDuration (concatDuration (List.map Duration.calculateTotalExerciseDuration part.exercises))
                    )
                )
            ]
        , column [
        ] (List.map viewTrainingPlanExercise part.exercises)
        ]
