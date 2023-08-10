module Main exposing (..)

import Browser
import Duration exposing (..)
import Element exposing (Attribute, Color, Element, alignRight, centerY, column, el, fill, height, layout, padding, paragraph, rgb255, row, spacing, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import TrainingPlan exposing (..)
import TrainingPlanHelper exposing (..)
import UtilsHelper exposing (..)



-- MAIN


main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }



-- MODEL from TrainingPlan.elm
-- INIT


init : Model
init =
    --Model (createDefaultTrainingPlan "Training plan" "Yoann K." "Unknown")
    Model createTestTrainingPlan



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        DelPlanPartMsg part ->
            removePlanPartFromModel model part

        DelPlanExerciseMsg part exo ->
            removeExerciseFromModel model part exo

        DelPlanExerciseSubPartMsg part exo exosubpart ->
            removeExerciseSubPartFromModel model part exo exosubpart

        _ ->
            model



-- VIEW


view : Model -> Html Msg
view model =
    layout [] (viewTrainingPlan model.plan)



-------------------------------------------------------------------------------
-- VIEWS
-------------------------------------------------------------------------------


styleTextHeader : List (Attribute Msg)
styleTextHeader =
    [ padding 1
    , Font.size 13
    ]


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


stylePartHeader : List (Attribute Msg)
stylePartHeader =
    [ padding 1
    , Font.size 16
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
            , Input.button [ alignRight ] { onPress = Just (DelPlanPartMsg part), label = text "❌" }
            ]
        , column
            [ width fill
            , padding 1
            ]
            (List.map (viewTrainingPlanExercise part) part.exercises)
        ]


viewTrainingPlanExercise : TrainingPlanPart -> TrainingPlanExercise -> Element Msg
viewTrainingPlanExercise part exo =
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
        , Input.button [ alignRight, Font.size 8 ] { onPress = Just (DelPlanExerciseMsg part exo), label = text "❌" }
        ]


styleExerciceSubPartHeader : List (Attribute Msg)
styleExerciceSubPartHeader =
    [ spacing 2
    , padding 1
    , Border.color mainColor
    , Border.width 1
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
