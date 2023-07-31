module ViewTrainingPlan exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import TrainingPlan exposing (..)
import TrainingPlanHelper exposing (..)
import ViewExercise exposing (..)
import Duration exposing (..)


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
    , span [class "location"] [(text (formatExerciseLocation part.location))]              
    , span [class "final_duration"] [text ("Durée totale : " ++ (
      formatDuration (concatDuration (List.map Duration.calculateTotalExerciseDuration part.exercises))
      )
    )]              
    , div [ class "plan_part_exercise_list"] (List.map viewTrainingPlanExercise part.exercises)
  ]

