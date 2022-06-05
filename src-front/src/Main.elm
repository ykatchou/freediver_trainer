module Main exposing(..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Json.Decode exposing (string)

import TrainingPlan exposing (..)
import TrainingPlanHelper exposing (createNewTrainingPlan)


-- MAIN
main =
  Browser.sandbox { init = init, update = update, view = view }


-- MODEL
type alias Model =
  { 
    plan: TrainingPlan
  }


init : Model
init =
  Model (createNewTrainingPlan "default_name" "default_author" "default_group")


-- UPDATE

type Msg
  = Name String

update : Msg -> Model -> Model
update msg model =
  case msg of
    _ ->
      model


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ 
      viewInput "text" "Name" model.name Name
    , viewInput "password" "Password" model.password Password
    , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
    , viewValidation model
    ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
  if model.password == model.passwordAgain then
    div [ style "color" "green" ] [ text "OK" ]
  else
    div [ style "color" "red" ] [ text "Passwords do not match!" ]