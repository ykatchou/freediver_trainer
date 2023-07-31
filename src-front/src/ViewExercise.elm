module ViewExercise exposing (..)

import Element exposing (Element, el, text, row, column, paragraph, alignRight, fill, width, rgb255, spacing, centerY, padding)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font

import TrainingPlan exposing(..)
import TrainingPlanHelper exposing (..)
import Duration exposing(..)
import Element exposing (Color)

viewTrainingPlanExercise: TrainingPlanExercise -> Element Msg
viewTrainingPlanExercise exo =
  row [ 
            padding 1
            , Border.color (rgb255 0 255 0)
            , Border.width 1
            , Border.rounded 3
   ]
  [
    el [
      padding 1
    ] (text (formatExerciseFamily exo.family))
    , el [
      padding 1
    ] (text exo.name)
    , el [] (text exo.comment)
    , el [] (text (formatRepeat exo.repeat))

    , column [  ] 
      [
      case exo.family of
        _ ->
          viewGenericExercise exo
      ]
  ]

viewGenericExercise: TrainingPlanExercise -> Element Msg
viewGenericExercise exo =
  row [ Background.color <| rgb255 255 255 255 
    , Font.color <| rgb255 0 0 0
  ] (
    exo.parts
        |> List.map viewGenericExerciseSubPart
  )

viewGenericExerciseSubPart: TrainingPlanExerciseSubPart -> Element Msg
viewGenericExerciseSubPart exosubpart =
  case exosubpart.kind of
  Rest ->
    el [] (text ("Repos: "++ (formatDuration exosubpart.rest)))

  Dry ->
    el [] (text (
      "Au sec durant: "++ (formatDuration exosubpart.duration)
      ))

  Breath ->
    el [] (text (
        "Inspiration: "++ (formatDuration exosubpart.duration)
        ++ " Expiration: "++ (formatDuration exosubpart.rest)
    ))
  
  Swim ->
    el [] (text (
        (formatExerciseCategory exosubpart.kind) ++ " : "
        ++ " Distance: "++ (formatDistance exosubpart.distance) 
        ++ " Durée: "++ (formatDuration exosubpart.duration)
        ++ " Repos: "++ (formatDuration exosubpart.rest)
    ))

  DNF ->
    el [] (text (
        (formatExerciseCategory exosubpart.kind) ++ " : "
        ++ " Distance: "++ (formatDistance exosubpart.distance) 
        ++ " Durée: "++ (formatDuration exosubpart.duration)
        ++ " Repos: "++ (formatDuration exosubpart.rest)

    ))

  DYN ->
    el [] (text (
        (formatExerciseCategory exosubpart.kind) ++ " : "
        ++ " Distance: "++ (formatDistance exosubpart.distance) 
        ++ " Durée: "++ (formatDuration exosubpart.duration)
        ++ " Repos: "++ (formatDuration exosubpart.rest)

    ))

  STA ->
    el [] (text (
       (formatExerciseCategory exosubpart.kind) ++ " : "
        ++ " Durée: "++ (formatDuration exosubpart.duration)
        ++ " Repos: "++ (formatDuration exosubpart.rest)

    ))

  CNF ->
    el [] (text (
        (formatExerciseCategory exosubpart.kind) ++ " : "
        ++ " Profondeur: "++ (formatDistance exosubpart.depth)
        ++ " Durée: "++ (formatDuration exosubpart.duration)
        ++ " Repos: "++ (formatDuration exosubpart.rest)

    ))

  CWT ->
    el [] (text (
        (formatExerciseCategory exosubpart.kind) ++ " : "
        ++ " Profondeur: "++ (formatDistance exosubpart.depth)
        ++ " Durée: "++ (formatDuration exosubpart.duration)
        ++ " Repos: "++ (formatDuration exosubpart.rest)

    ))

  FIM ->
    el [] (text (
        (formatExerciseCategory exosubpart.kind) ++ " : "
        ++ " Profondeur: "++ (formatDistance exosubpart.depth)
        ++ " Durée: "++ (formatDuration exosubpart.duration)
        ++ " Repos: "++ (formatDuration exosubpart.rest)
    ))

  VWT ->
    el [] (text (
        (formatExerciseCategory exosubpart.kind) ++ " : "
        ++ " Profondeur: "++ (formatDistance exosubpart.depth)
        ++ " Durée: "++ (formatDuration exosubpart.duration)
        ++ " Repos: "++ (formatDuration exosubpart.rest)
    ))

  _ ->
    el [] (text (
        (formatExerciseCategory exosubpart.kind) ++ " : "
        ++ " Distance: "++ (formatDistance exosubpart.distance) 
        ++ " Profondeur: "++ (formatDistance exosubpart.depth)
        ++ " Durée: "++ (formatDuration exosubpart.duration)
        ++ " Repos: "++ (formatDuration exosubpart.rest)
        ))