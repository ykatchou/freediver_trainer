module Acc exposing (plan, parts, exercises, matching)

import Accessors exposing (makeOneToOne, makeOneToN, Relation)

plan = makeOneToOne
  .plan
  (\change record -> {record | plan = change record.plan})

parts = makeOneToOne
  .parts
  (\change record -> {record | parts = change record.parts})

exercises = makeOneToOne
  .exercises
  (\change record -> {record | exercises = change record.exercises})

matching predicate = makeOneToN
  (\f list -> List.filter (\content -> predicate content) list |> List.map f)
  (\f list -> List.map (\content -> if predicate content then f content else content) list)
