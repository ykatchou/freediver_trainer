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

matching x = makeOneToN
  (\f list -> List.filter (\e -> e == x) list |> List.map f)
  (\f list -> List.map (\content -> if content == x then f x else x) list)
