module TrainingPlan exposing (..)

type ExerciseLocation =
  NoWater
  | SwimmingPool25m
  | SwimmingPool50m
  | SmallPool
  | DeepPool

type ExerciseFamily =
  Unknown
  | Break
  | Duration
  | Distance
  | Depth
  | Relaxation
  | Composite

type ExerciseCategory =
  Custom
  | Rest 
  | Dry
  | Breath
  | Swim
  | DNF
  | DYN
  | STA 
  | CNF
  | CWT
  | FIM
  | VWT

type alias TrainingPlan =
  {
    name: String
    , author: String
    , lastchangedate: String
    , group : String
    , parts : List TrainingPlanPart
  }

type alias TrainingPlanPart =
  { 
    name : String
    , location: ExerciseLocation
    , exercises : List TrainingPlanExercise
  }

type alias TrainingPlanExercise =
  { 
    family : ExerciseFamily
    , name : String
    , comment : String
    , repeat : Int
    , parts : List TrainingPlanExerciseSubPart
  }

type alias TrainingPlanExerciseSubPart = 
  {
    kind: ExerciseCategory
    , distance: Int
    , depth: Int
    , duration: Timer
    , rest: Timer
  }

type alias Timer =
  { 
    min: Int, 
    sec: Int
  }
