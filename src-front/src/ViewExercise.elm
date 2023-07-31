module ViewExercise exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import TrainingPlan exposing(..)
import TrainingPlanHelper exposing (..)
import Duration exposing(..)

viewTrainingPlanExercise: TrainingPlanExercise -> Html Msg
viewTrainingPlanExercise exo =
  div [ class "plan_part_exercise"]
  [
    span [] [text (formatExerciseFamily exo.family)]
    , span [] [text ("Répétitions : " ++ (String.fromInt exo.repeat))]
    , span [] [text exo.comment]
    , span [] [text ("Total : " ++ (formatDuration (calculateTotalExerciseDuration exo)))]

    , div [ class "exercise_content"] [
      case exo.family of
        _ ->
          viewGenericExercise exo
      ]
  ]

viewGenericExercise: TrainingPlanExercise -> Html Msg
viewGenericExercise exo =
  span [] (
    exo.parts
        |> List.map viewGenericExerciseSubPart
  )

viewGenericExerciseSubPart: TrainingPlanExerciseSubPart -> Html Msg
viewGenericExerciseSubPart exosubpart =
  case exosubpart.kind of
  Rest ->
    span [] [(text ("Repos: "++ (formatDuration exosubpart.rest)))]

  Dry ->
    span [] [(text (
      "Au sec durant: "++ (formatDuration exosubpart.duration)
      ))]

  Breath ->
    span [] [(text (
        "Inspiration: "++ (formatDuration exosubpart.duration)
        ++ " Expiration: "++ (formatDuration exosubpart.rest)
    ))]
  
  Swim ->
    span [] [(text (
        (formatExerciseCategory exosubpart.kind) ++ " : "
        ++ " Distance: "++ (formatDistance exosubpart.distance) 
        ++ " Durée: "++ (formatDuration exosubpart.duration)
        ++ " Repos: "++ (formatDuration exosubpart.rest)
    ))]

  DNF ->
    span [] [(text (
        (formatExerciseCategory exosubpart.kind) ++ " : "
        ++ " Distance: "++ (formatDistance exosubpart.distance) 
        ++ " Durée: "++ (formatDuration exosubpart.duration)
        ++ " Repos: "++ (formatDuration exosubpart.rest)

    ))]

  DYN ->
    span [] [(text (
        (formatExerciseCategory exosubpart.kind) ++ " : "
        ++ " Distance: "++ (formatDistance exosubpart.distance) 
        ++ " Durée: "++ (formatDuration exosubpart.duration)
        ++ " Repos: "++ (formatDuration exosubpart.rest)

    ))]

  STA ->
    span [] [(text (
       (formatExerciseCategory exosubpart.kind) ++ " : "
        ++ " Durée: "++ (formatDuration exosubpart.duration)
        ++ " Repos: "++ (formatDuration exosubpart.rest)

    ))]

  CNF ->
    span [] [(text (
        (formatExerciseCategory exosubpart.kind) ++ " : "
        ++ " Profondeur: "++ (formatDistance exosubpart.depth)
        ++ " Durée: "++ (formatDuration exosubpart.duration)
        ++ " Repos: "++ (formatDuration exosubpart.rest)

    ))]

  CWT ->
    span [] [(text (
        (formatExerciseCategory exosubpart.kind) ++ " : "
        ++ " Profondeur: "++ (formatDistance exosubpart.depth)
        ++ " Durée: "++ (formatDuration exosubpart.duration)
        ++ " Repos: "++ (formatDuration exosubpart.rest)

    ))]

  FIM ->
    span [] [(text (
        (formatExerciseCategory exosubpart.kind) ++ " : "
        ++ " Profondeur: "++ (formatDistance exosubpart.depth)
        ++ " Durée: "++ (formatDuration exosubpart.duration)
        ++ " Repos: "++ (formatDuration exosubpart.rest)
    ))]

  VWT ->
    span [] [(text (
        (formatExerciseCategory exosubpart.kind) ++ " : "
        ++ " Profondeur: "++ (formatDistance exosubpart.depth)
        ++ " Durée: "++ (formatDuration exosubpart.duration)
        ++ " Repos: "++ (formatDuration exosubpart.rest)
    ))]

  _ ->
    span [] [(text (
        (formatExerciseCategory exosubpart.kind) ++ " : "
        ++ " Distance: "++ (formatDistance exosubpart.distance) 
        ++ " Profondeur: "++ (formatDistance exosubpart.depth)
        ++ " Durée: "++ (formatDuration exosubpart.duration)
        ++ " Repos: "++ (formatDuration exosubpart.rest)
        ))]