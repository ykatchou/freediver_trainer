module TrainingPlanView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


import TrainingPlan exposing(..)
import TrainingPlanHelper exposing (..)
import Duration exposing(..)


viewTrainingPlan: TrainingPlan -> Html Msg
viewTrainingPlan plan=
  div [ class "plan" ]
    [ 
        span [class "plan_name"] [(text ("Entrainement :" ++ plan.name))]
      , span [class "plan_group"] [(text ("Groupe : " ++ plan.group))]
      , span [class "plan_author"] [(text ("Moniteur : " ++ plan.author))]
      , div [ class "plan_part_list" ] (List.map viewTrainingPlanPart plan.parts)
    ]


viewTrainingPlanPart: TrainingPlanPart -> Html Msg
viewTrainingPlanPart part=
  div [ class "plan_part"]
  [
    span [] [(text part.name)]

    , -- Change location rendering
      case part.location of
        NoWater ->
          span [class "location"] [(text "Au sec")]
        SwimmingPool25m ->
          span [class "location"] [(text "Grand Bain (25m)")]
        SwimmingPool50m ->
          span [class "location"] [(text "Grand Bain (50m)")]
        SmallPool ->
          span [class "location"] [(text "Petit bain")]
        DeepPool ->
          span [class "location"] [(text "Fosse")]
              
    , div [ class "plan_part_exercise_list"] (List.map viewTrainingPlanExercise part.exercises)
  ]


viewTrainingPlanExercise: TrainingPlanExercise -> Html Msg
viewTrainingPlanExercise exo =
  div [ class "plan_part_exercise"]
  [
    case exo.category of
      Rest cat ->
        viewRestExercise cat
      Swim cat ->
        viewDistanceExercise "Swim" cat
      DYN cat ->
        viewDistanceExercise "DYN" cat
      DNF cat ->
        viewDistanceExercise "DNF" cat

      STA cat ->
        viewDurationExercise "STA" cat
      Dry cat ->
        viewDurationExercise "Dry" cat

      CWT cat ->
        viewDepthExercise "CWT" cat
      CNF cat ->
        viewDepthExercise "CNF" cat
      FIM cat ->
        viewDepthExercise "FIM" cat
      VWT cat ->
        viewDepthExercise "VWT" cat
      
      _ ->
        span [] [(text "Unkown")]
    , span [] [text (String.fromInt exo.repeat)]
    , span [] [text exo.comment]
    , span [] [text (formatDuration (calculateTotalExerciseDuration exo))]
  ]


viewRestExercise: RestExercise -> Html Msg
viewRestExercise exo =
  span [class "rest"] [
    (text ("Rest: "++ (formatDuration exo.rest)))
  ]

viewDurationExercise: String -> DurationExercise -> Html Msg
viewDurationExercise cat_name exo =
  span [] [
    (text (" Duration: "++ (formatDuration exo.duration)
      ++ " Rest: "++ (formatDuration exo.rest)))
  ]

viewDistanceExercise: String -> DistanceExercise -> Html Msg
viewDistanceExercise cat_name exo =
  span [] [
    (text ("Distance: "++ (formatDistance exo.distance) 
      ++ " Duration: "++ (formatDuration exo.duration)
      ++ " Rest: "++ (formatDuration exo.rest)))
  ]

viewDepthExercise: String -> DepthExercise -> Html Msg
viewDepthExercise cat_name exo =
  div []
  [
    span [] [ text cat_name]
    ,span [] [
      (text ("Depth: "++ (formatDistance exo.depth) 
        ++ " Duration: "++ (formatDuration exo.duration)
        ++ " Rest: "++ (formatDuration exo.rest)))
      ]
  ]
