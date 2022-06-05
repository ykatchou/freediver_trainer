module Main exposing(..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Json.Decode exposing (string)

import TrainingPlan exposing (..)
import TrainingPlanHelper exposing (..)
import TrainingPlanView exposing(..)


-- MAIN
main : Program () Model Msg
main =
  Browser.sandbox { init = init, update = update, view = view }


-- MODEL
type alias Model =
  { 
    plan: TrainingPlan
  }

init : Model
init =
  Model (createDefaultTrainingPlan "My Training Plan" "Yoann Katchourine" "Mid-beginner")


-- UPDATE
update : Msg -> Model -> Model
update msg model =
  case msg of
    _ ->
      model


-- VIEW

view : Model -> Html Msg
view model =
  div [ class "main" ]
    [ 
      (viewTrainingPlan model.plan)
    ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
    div [ style "color" "red" ] [ text "Passwords do not match!" ]