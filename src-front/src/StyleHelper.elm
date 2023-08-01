module StyleHelper exposing (..)
import Element exposing (Element, Attribute, Color, alignRight, centerY, column, el, fill, padding, rgb255, spacing, width)
import Element.Font as Font
import UtilsHelper exposing (Msg)
import Element exposing (Attr)

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


styleTextHeader : List (Attribute Msg)
styleTextHeader =
    [
        padding 1
        , Font.size 14
    ]

stylePartHeader : List (Attribute Msg)
stylePartHeader =
    [
        padding 1
        , Font.size 14
    ]

styleExerciceSubPartHeader : List (Attribute Msg)
styleExerciceSubPartHeader = 
    [
        spacing 5
    ]