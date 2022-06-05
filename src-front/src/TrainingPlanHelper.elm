module TrainingPlanHelper exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import TrainingPlan exposing(..)
import Debug exposing (toString)
import String exposing (toInt)


type Msg
  = Name String

createDurationFromSec: Int -> Duration
createDurationFromSec s=
  let m = s // 60
  in
    Duration m (s-(m*60))

createDurationFromMin: Int -> Duration
createDurationFromMin m=
    Duration m 0

calculateTotalExerciseDuration: TrainingPlanExercise -> Duration
calculateTotalExerciseDuration exo=
  Duration 0 0
    --TODO calculateTotalExerciseDuration


calculateTotalPartDuration: TrainingPlanPart -> Duration
calculateTotalPartDuration part=
  Duration 0 0
  --TODO calculateTotalPartDuration


createDefaultTrainingPlan: String -> String -> String -> TrainingPlan
createDefaultTrainingPlan name author group=
  TrainingPlan name author "" group [
    TrainingPlanPart "Briefing" NoWater [
      TrainingPlanExercise Unknown "Session explanations" 0
      , TrainingPlanExercise 
          (Squarred
            (SquarredExercise
              (createDurationFromSec 15)
              (createDurationFromSec 15)
              (createDurationFromSec 15)
              (createDurationFromSec 15)
            ))
         "Squarred" 4
    ]

    ,TrainingPlanPart "Corpus" SwimmingPool25m [
      TrainingPlanExercise (DYN (DistanceExercise 25 (createDurationFromSec 30) (createDurationFromSec 30))) "First 16x25" 16
      , TrainingPlanExercise(Rest (RestExercise (createDurationFromMin 2))) "" 1
      ,TrainingPlanExercise (DYN (DistanceExercise 50 (createDurationFromSec 60) (createDurationFromSec 45))) "Second DYN" 1
    ]

    ,TrainingPlanPart "Debriefing" NoWater [
      TrainingPlanExercise (Rest (RestExercise (createDurationFromMin 5))) "Session debrief" 1
    ]
  ]


viewTrainingPlan: TrainingPlan -> Html Msg
viewTrainingPlan plan=
  div [ class "plan" ]
    [ 
        span [] [(text plan.name)]
      , span [] [(text plan.group)]
      , span [] [(text plan.author)]
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
          span [] [(text "Au sec")]
        SwimmingPool25m ->
          span [] [(text "Grand Bain (25m)")]
        SwimmingPool50m ->
          span [] [(text "Grand Bain (50m)")]
        SmallPool ->
          span [] [(text "Petit bain")]
        DeepPool ->
          span [] [(text "Fosse")]
              
    , div [ class "plan_part_exercise_list"] (List.map viewTrainingPlanExercise part.exercises)
  ]


viewTrainingPlanExercise: TrainingPlanExercise -> Html Msg
viewTrainingPlanExercise exo =
  div [ class "plan_part_exercise"]
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
