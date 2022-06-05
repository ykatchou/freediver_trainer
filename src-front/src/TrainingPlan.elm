module TrainingPlan exposing (..)


type alias TrainingPlan =
  {
    name: String
    , author: String
    , lastchangedate: String
    -- class name
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
    category : ExerciseCategory
    , comment : String
    , repeat : Int
  }

type alias Duration =
  { 
    min: Int, 
    sec: Int
  }

type ExerciseLocation =
  NoWater
  | SwimmingPool25m
  | SwimmingPool50m
  | SmallPool
  | DeepPool

type alias RestExercise =
  { rest: Duration}

type alias DurationExercise =
  { duration: Duration, rest: Duration }

type alias DistanceExercise =
  { distance: Int, duration: Duration, rest: Duration }

type alias DepthExercise =
  { depth: Int, duration: Duration, rest: Duration }

type alias SquarredExercise =
  { inspire:Duration, hold:Duration, expire:Duration, hold_empty: Duration}

type ExerciseCategory =
  Unknown
  | Rest RestExercise
  | Swim DistanceExercise

  | DYN DistanceExercise
  | DNF DistanceExercise
  | DYN_STA  { dyn: DistanceExercise, sta_final: DurationExercise }
  | STA_DYN  { dyn: DistanceExercise, sta_initial: DurationExercise }
  | STA_DYN_STA  { dyn: DistanceExercise, sta_initial: DurationExercise, sta_final: DurationExercise }

  | STA  DurationExercise
  | Dry DurationExercise

  | CWT DepthExercise
  | CNF DepthExercise
  | FIM DepthExercise
  | VWT DepthExercise

  | Squarred SquarredExercise

