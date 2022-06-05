module TrainingPlanModel exposing (..)


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
    , location: ExerciceLocation
    , exercices : List TrainingPlanExercice
  }

type alias TrainingPlanExercice =
  { 
    category : ExerciceType
    , comment : String
    , repeat : Int
  }


type ExerciceLocation =
  NoWater
  | SwimmingPool25m
  | SwimmingPool50m
  | SmallPool
  | DeepPool

type alias RestExercice =
  { rest: Int}

type alias DurationExercice =
  { duration: Int, rest: Int }

type alias DistanceExercice =
  { distance: Int, duration: Int, rest: Int }

type alias DepthExercice =
  { depth: Int, duration: Int, rest: Int }


type ExerciceType =
  Unknown
  | Rest RestExercice
  | Swim DistanceExercice

  | DYN DistanceExercice
  | DNF DistanceExercice
  | DYN_STA  { dyn: DistanceExercice, sta_final: DurationExercice }
  | STA_DYN  { dyn: DistanceExercice, sta_initial: DurationExercice }
  | STA_DYN_STA  { dyn: DistanceExercice, sta_initial: DurationExercice, sta_final: DurationExercice }

  | STA  DurationExercice
  | Dry DurationExercice

  | CWT DepthExercice
  | CNF DepthExercice
  | FIM DepthExercice

  | Breath DurationExercice
  | Exhale DurationExercice
  | Hold DurationExercice

