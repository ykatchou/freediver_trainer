module ViewExercise exposing (..)

import Duration exposing (..)
import Element exposing (Color, Element, alignRight, centerY, column, el, fill, padding, paragraph, rgb255, row, spaceEvenly, spacing, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import StyleHelper exposing (..)
import TrainingPlan exposing (..)
import TrainingPlanHelper exposing (..)
import UtilsHelper exposing (..)


viewTrainingPlanExercise : TrainingPlanExercise -> Element Msg
viewTrainingPlanExercise exo =
    row
        [ spacing 3
        , padding 1
        , width fill
        ]
        [ text (formatExerciseFamily exo.family)
        , text exo.name
        , text exo.comment
        , el [ Font.bold ] (text (formatIfValue "x" exo.repeat ""))
        , viewGenericExercise exo
        ]


viewGenericExercise : TrainingPlanExercise -> Element Msg
viewGenericExercise exo =
    column
        [ Background.color <| white
        , Font.color <| secondColor
        , Font.size 14
        , width fill
        , spacing 1
        ]
        (exo.parts
            |> List.map viewGenericExerciseSubPart
        )


viewGenericExerciseSubPart : TrainingPlanExerciseSubPart -> Element Msg
viewGenericExerciseSubPart exosubpart =
    case exosubpart.kind of
        Rest ->
            displayRest exosubpart

        Dry ->
            row styleExerciceSubPartHeader
                [ displayKind exosubpart
                , displayTimeduration exosubpart
                ]

        Breath ->
            row styleExerciceSubPartHeader
                [ displayKind exosubpart
                , displayTimeduration exosubpart
                , displayRest exosubpart
                ]

        _ ->
            row styleExerciceSubPartHeader
                [ displayKind exosubpart
                , displayDistance exosubpart
                , displayDepth exosubpart
                , displayTimeduration exosubpart
                , displayRest exosubpart
                ]


displayKind : TrainingPlanExerciseSubPart -> Element Msg
displayKind exosubpart =
    text (formatIfValueStr "" (formatExerciseCategory exosubpart.kind) "")


displayDistance : TrainingPlanExerciseSubPart -> Element Msg
displayDistance exosubpart =
    text (formatIfValueStr "" (formatDistance exosubpart.distance) "")


displayDepth : TrainingPlanExerciseSubPart -> Element Msg
displayDepth exosubpart =
    text (formatIfValueStr "" (formatDistance exosubpart.depth) "")


displayTimeduration : TrainingPlanExerciseSubPart -> Element Msg
displayTimeduration exosubpart =
    if (exosubpart.depth > 0) || (getsecondsFromDuration exosubpart.duration > 0) then
        text (formatIfValueStr "(" (formatDuration exosubpart.duration) ")")

    else
        text ""


displayRest : TrainingPlanExerciseSubPart -> Element Msg
displayRest exosubpart =
        (if exosubpart.kind == TrainingPlan.Rest then
            text (formatIfValueStr " " (formatDuration exosubpart.rest) "")

         else
            text (formatIfValueStr "🚧 " (formatDuration exosubpart.rest) "")
        )
