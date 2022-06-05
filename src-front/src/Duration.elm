module Duration exposing (..)

import TrainingPlan exposing(..)

createDurationFromSec: Int -> Duration
createDurationFromSec secs =
  let m = secs // 60
  in
    Duration m ( secs - (m*60) )

createDurationFromMin: Int -> Duration
createDurationFromMin m=
    Duration m 0

getsecondsFromDuration: Duration -> Int
getsecondsFromDuration dur=
  (dur.min*60)+dur.sec

calculateTotalExerciseDuration: TrainingPlanExercise -> Duration
calculateTotalExerciseDuration exo=
  case exo.category of
    Rest re ->
      createDurationFromSec ((getsecondsFromDuration re.rest) * exo.repeat)
    Swim de ->
      createDurationFromSec ((getsecondsFromDuration de.duration + getsecondsFromDuration de.rest)*exo.repeat)
    DYN de ->
      createDurationFromSec ((getsecondsFromDuration de.duration + getsecondsFromDuration de.rest)*exo.repeat)
    DNF de ->
      createDurationFromSec ((getsecondsFromDuration de.duration + getsecondsFromDuration de.rest)*exo.repeat)

    DYN_STA de ->
      createDurationFromSec ((
        getsecondsFromDuration de.dyn.duration + getsecondsFromDuration de.dyn.rest
        + getsecondsFromDuration de.sta_final.duration + getsecondsFromDuration de.sta_final.rest
      )*exo.repeat)
    STA_DYN de ->
      createDurationFromSec ((
        getsecondsFromDuration de.sta_initial.duration + getsecondsFromDuration de.sta_initial.rest
        + getsecondsFromDuration de.dyn.duration + getsecondsFromDuration de.dyn.rest
      )*exo.repeat)    
    STA_DYN_STA de ->
      createDurationFromSec ((
        getsecondsFromDuration de.sta_initial.duration + getsecondsFromDuration de.sta_initial.rest
        + getsecondsFromDuration de.dyn.duration + getsecondsFromDuration de.dyn.rest
        + getsecondsFromDuration de.sta_final.duration + getsecondsFromDuration de.sta_final.rest
      )*exo.repeat)

    STA de ->
      createDurationFromSec ((getsecondsFromDuration de.duration + getsecondsFromDuration de.rest)*exo.repeat)
    Dry de ->
      createDurationFromSec ((getsecondsFromDuration de.duration + getsecondsFromDuration de.rest)*exo.repeat)

    CWT de ->
      createDurationFromSec ((getsecondsFromDuration de.duration + getsecondsFromDuration de.rest)*exo.repeat)
    CNF de ->
      createDurationFromSec ((getsecondsFromDuration de.duration + getsecondsFromDuration de.rest)*exo.repeat)
    FIM de ->
      createDurationFromSec ((getsecondsFromDuration de.duration + getsecondsFromDuration de.rest)*exo.repeat)
    VWT de ->
      createDurationFromSec ((getsecondsFromDuration de.duration + getsecondsFromDuration de.rest)*exo.repeat)

    Squarred de ->
      createDurationFromSec ((getsecondsFromDuration de.inspire
        + getsecondsFromDuration de.hold
        + getsecondsFromDuration de.expire
        + getsecondsFromDuration de.hold_empty
        )*exo.repeat)

    _ ->
      createDurationFromSec 0

formatDuration: Duration -> String
formatDuration dur=
    if dur.min > 0 then
        if dur.sec > 0 then
            (String.fromInt dur.min) ++ "min " ++ (String.fromInt dur.sec) ++ "sec"
        else
            (String.fromInt dur.min) ++ "min "
    else
        (String.fromInt dur.sec) ++ "sec"
