module ViewTrainingPlan exposing (..)

import Duration exposing (..)
import Element exposing (Attribute, Color, Element, alignRight, centerY, column, el, fill, padding, paragraph, rgb255, row, spacing, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import StyleHelper exposing (..)
import TrainingPlan exposing (..)
import TrainingPlanHelper exposing (..)
import UtilsHelper exposing (..)
import ViewExercise exposing (..)


viewTrainingPlan : TrainingPlan -> Element Msg
viewTrainingPlan plan =
    column
        [ width fill
        , Background.color white
        , Font.color black
        , Border.rounded 3
        , padding 1
        ]
        [ row [ padding 1 ]
            [ el styleTextHeader (text ("Entrainement : " ++ plan.name))
            , el styleTextHeader (text ("Groupe : " ++ plan.group))
            , el styleTextHeader
                (text
                    ("Durée totale : "
                        ++ formatDuration (Duration.calculateTrainingPlanDuration plan)
                    )
                )
            , el styleTextHeader (text ("Moniteur : " ++ plan.author))
            ]
        , column
            [ spacing 5 ]
            (List.map viewTrainingPlanPart plan.parts)
        ]


viewTrainingPlanPart : TrainingPlanPart -> Element Msg
viewTrainingPlanPart part =
    column
        [ Background.color white
        , width fill
        , Font.color mainColor
        , Font.size 16
        , Border.color mainColor
        , Border.width 1
        , Border.rounded 5
        ]
        [ row
            [ width fill
            , Border.color mainColor
            , Border.width 1
            , Background.color mainColor
            , Font.color white
            ]
            [ el stylePartHeader (text part.name)
            , el stylePartHeader (text (formatExerciseLocation part.location))
            , el stylePartHeader (text (formatIfValueStr "(" (formatDuration (calculateTrainingPlanPartDuration part)) ")"))
            ]
        , column
            [ width fill 
            , padding 1]
            (List.map viewTrainingPlanExercise part.exercises)
        ]
