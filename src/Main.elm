module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Html.App exposing (beginnerProgram)


-- # Main


main : Program Never
main =
    beginnerProgram
        { model = init
        , view = view
        , update = update
        }



-- # Model


type alias Model =
    {isOn: List Bool}


--init : Model
init =
    {isOn = [True, True, True]}


-- # Messages


type Msg
    = Toggle Int



-- # Update


update : Msg -> Model -> Model
update msg model =
    case msg of
        Toggle ix ->
            {model | isOn = toggleLights ix model.isOn}


toggleLights : Int -> List Bool -> List Bool
toggleLights ix list =
    List.indexedMap
        (\i isOn ->
            if ix == i then
                not isOn
            else if ix == i + 1 then
                not isOn
            else if ix == i - 1 then
                not isOn
            else
                isOn
        ) list
-- # View


view : Model -> Html Msg
view model =
    div [ class "container" ]
    [
        model.isOn
            |> List.indexedMap btn
            |> div []

    ]

btn : Int -> Bool -> Html Msg
btn ix isOn =
    div [
            style [
            ("background-color",
                if isOn then
                    "orange"
                else
                    "grey")
            , ( "width", "40px" )
            , ( "height", "40px" )
            , ( "margin", "2px" )
            , ( "display", "inline-block" )
            ]
            , onClick (Toggle ix)
        ]
        []