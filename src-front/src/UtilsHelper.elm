module UtilsHelper exposing (..)

import Element exposing (Attribute, Color, Element, alignRight, centerY, column, el, fill, height, layout, padding, paragraph, rgb255, row, spacing, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import TrainingPlan exposing (..)


formatIfValueStr : String -> String -> String -> String
formatIfValueStr spre rep spos =
    if String.length rep > 0 then
        spre ++ rep ++ spos

    else
        ""


formatIfValue : String -> Int -> String -> String
formatIfValue spre rep spos =
    if rep > 1 then
        spre ++ String.fromInt rep ++ spos

    else
        ""


formatDistance : Int -> String
formatDistance dist =
    formatIfValue "" dist "m"



--- Styling part


mainColor : Color
mainColor =
    rgb255 86 169 210


secondColor : Color
secondColor =
    rgb255 241 105 41


white : Color
white =
    rgb255 255 255 255


black : Color
black =
    rgb255 0 0 0
