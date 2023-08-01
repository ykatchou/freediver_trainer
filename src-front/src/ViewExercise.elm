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
import Element.Font exposing (family)


viewTrainingPlanExercise : TrainingPlanExercise -> Element Msg
viewTrainingPlanExercise exo =
    row
        [ spacing 3
        , padding 0
        , width fill
        ]
        [ text (formatExerciseFamily exo.family)
        , text exo.name
        , text exo.comment
        , el [ Font.bold ] (text (formatIfValue "x" exo.repeat ""))
        , row
            [ Background.color <| white
            , Font.color <| secondColor
            , Font.size 14
            , width fill
            , spacing 5
            ]
            (exo.parts
                |> List.map (viewGenericExerciseSubPart exo)
            )
        ]


viewGenericExerciseSubPart : TrainingPlanExercise -> TrainingPlanExerciseSubPart -> Element Msg
viewGenericExerciseSubPart exo exosubpart =
    case exosubpart.kind of
        Rest ->
          el styleExerciceSubPartHeader
            (displayRest exo.family exosubpart)

        Dry ->
            row styleExerciceSubPartHeader
                [ displayKind exosubpart
                , displayTimeduration exo.family exosubpart
                ]

        Breath ->
            row styleExerciceSubPartHeader
                [ displayKind exosubpart
                , displayTimeduration exo.family exosubpart
                , displayRest exo.family exosubpart
                ]
        _ ->
            row styleExerciceSubPartHeader
                [ displayKind exosubpart
                , displayDistance exosubpart
                , displayDepth exosubpart
                , displayTimeduration exo.family exosubpart
                , displayRest exo.family exosubpart
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


displayTimeduration : ExerciseFamily -> TrainingPlanExerciseSubPart -> Element Msg
displayTimeduration family exosubpart =
    case family of
        _ ->
          text (formatIfValueStr "(" (formatDuration exosubpart.duration) ")")

displayRest : ExerciseFamily -> TrainingPlanExerciseSubPart -> Element Msg
displayRest family exosubpart =
    if family == Break then
        text (formatIfValueStr "" (formatDuration exosubpart.rest) "")

    else
        text (formatIfValueStr "🚧 " (formatDuration exosubpart.rest) "")
