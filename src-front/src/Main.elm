module Main exposing(..)
import UtilsHelper exposing (..)
import Element exposing (Element, el, text, row, column, paragraph, alignRight, fill, width, rgb255, spacing, centerY, padding)

import TrainingPlan exposing (..)
import TrainingPlanHelper exposing (..)

import ViewTrainingPlan exposing(..)
import Element
import Element exposing (height)

-- MAIN
main = 
    Element.layout [
      height fill
    ] <| view init


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

view : Model -> Element Msg
view model =
  row []
  [
    viewTrainingPlan model.plan
  ]