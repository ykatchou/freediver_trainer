#[macro_use] extern crate rocket;
use rocket::fs::relative;
use rocket::fs::FileServer;

enum ExerciseLocation {
  NoWater,
  SwimmingPool25m,
  SwimmingPool50m,
  SmallPool,
  DeepPool
}

type ExerciseFamily {
  Unknown,
  Break,
  Duration,
  Distance,
  Depth,
  Relaxation,
  Composite
}

enum ExerciseCategory {
    Custom,
    Rest,
    Dry,
    Breath,
    Swim,
    DNF,
    DYN,
    STA,
    CNF,
    CWT,
    FIM,
    VWT,
  }

struct TrainingPlan{
    name: String,
    author: String,
    lastchangedate: String,
    group: String,
    parts: TrainingPlanPart[]
}

struct TrainingPlanPart{
    name: String,
    location: ExcerciceLocation,
    exercises: TrainingPlanExercise[]
}

struct TrainingPlanExercise{ 
    family: ExerciseFamily, 
    name : String,
    comment : String,
    repeat : i32
    parts: TrainingPlanExerciseSubPart[]
}

struct TrainingPlanExerciseSubPart{
    kind: ExerciseCategory,
    distance: i32
    depth: i32,
    duration: Timer,
    rest: Timer
}

struct Timer{ 
    min: i32, 
    sec: i32
}


fn list_all_training_plan() -> TrainingPlan[] {
    format!("GET ALL TRAINING")
}

fn get_unit_training_plan(id: u64) -> TrainingPlan {
    format!("GET TRAINING {}", id)
}

fn save_unit_training_plan(id: u64) -> TrainingPlan {
    format!("SAVE TRAINING {}", id)
}
