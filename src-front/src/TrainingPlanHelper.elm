module TrainingPlanHelper exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import TrainingPlan exposing(..)

import Main exposing (Msg)
import Debug exposing (toString)


createNewTrainingPlan: String -> String -> String -> TrainingPlan
createNewTrainingPlan name author group=
  TrainingPlan name author "" group [
    TrainingPlanPart "Briefing" NoWater []
    ,TrainingPlanPart "Corpus" SwimmingPool25m []
    ,TrainingPlanPart "Debriefing" NoWater []
  ]


viewTrainingPlan: TrainingPlan -> Html Msg
viewTrainingPlan plan=
div []
  [ 
      span [] [(text plan.name)]
    , span [] [(text plan.group)]
    , span [] [(text plan.author)]
    , div [] (List.map viewTrainingPlanPart plan.parts)
  ]

viewTrainingPlanPart: TrainingPlanPart -> Html Msg
viewTrainingPlanPart part=
  div []
  [
    span [] [(text part.name)]

    , -- Change location rendering
      case part.location of
        NoWater ->
          span [] [(text "Au sec")]
        SwimmingPool25m ->
          span [] [(text "Grand Bain (25m)")]
        SwimmingPool50m ->
          span [] [(text "Grand Bain (50m)")]
        SmallPool ->
          span [] [(text "Petit bain")]
        DeepPool ->
          span [] [(text "Fosse")]
              
    , div [] (List.map viewTrainingPlanExercise part.exercises)
  ]


viewTrainingPlanExercise: TrainingPlanExercise -> Html Msg
viewTrainingPlanExercise exo =
  div []
  [
      span [] [(text exo.comment)]
    , span [] [(text ("Repeat: " ++ (toString exo.repeat)))]
    , case exo.category of
      Rest cat ->
        viewRestExercise cat
      Swim cat ->
        viewDistanceExercise cat
      DYN cat ->
        viewDistanceExercise cat
      DNF cat ->
        viewDistanceExercise cat


      STA cat ->
        viewDurationExercise cat
      Dry cat ->
        viewDurationExercise cat

      CWT cat ->
        viewDepthExercise cat
      CNF cat ->
        viewDepthExercise cat
      FIM cat ->
        viewDepthExercise cat
      VWT cat ->
        viewDepthExercise cat
      
      Breath cat ->
        viewDurationExercise cat
      Exhale cat ->
        viewDurationExercise cat
      Hold cat ->
        viewDurationExercise cat

      
      DYN_STA cat ->
        ()
      STA_DYN cat ->
        ()
      STA_DYN_STA cat ->
        ()
      _ ->
        span [] [(text "Unkown")]

  ]
  
viewRestExercise: RestExercise -> Html Msg
viewRestExercise exo =
  span [] [
    (text (" Rest: "++ (toString exo.rest)))
  ]

viewDurationExercise: DurationExercise -> Html Msg
viewDurationExercise exo =
  span [] [
    (text (" Duration: "++ (toString exo.duration)
      ++ " Rest: "++ (toString exo.rest)))
  ]

viewDistanceExercise: DistanceExercise -> Html Msg
viewDistanceExercise exo =
  span [] [
    (text ("Distance: "++ (toString exo.distance) 
      ++ " Duration: "++ (toString exo.duration)
      ++ " Rest: "++ (toString exo.rest)))
  ]

viewDepthExercise: DepthExercise -> Html Msg
viewDepthExercise exo =
  span [] [
    (text ("Depth: "++ (toString exo.depth) 
      ++ " Duration: "++ (toString exo.duration)
      ++ " Rest: "++ (toString exo.rest)))
  ]
