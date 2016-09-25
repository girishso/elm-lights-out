--module Main exposing (..)


module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Html.App exposing (beginnerProgram)
import Matrix exposing (..)
import Matrix.Extra exposing (..)
import Array exposing (..)


type alias Player =
    String


type alias Model =
    { isOn : Matrix Bool
    }


init =
    { isOn = Matrix.repeat 5 5 True
    }


type alias Position =
    { x : Int, y : Int }


type Msg
    = Toggle Position
    | Restart


update : Msg -> Model -> Model
update msg model =
    -- case Debug.log "update:" of
    --   _
    case Debug.log "update:" msg of
        Toggle position ->
            if isSolved model then
                model
            else
                { model | isOn = Matrix.indexedMap (toggleLight position) model.isOn }

        Restart ->
            init


toggleLight : Position -> Int -> Int -> Bool -> Bool
toggleLight curPosition iy ix isOn =
    let
        _ =
            2

        -- _ =
        -- Debug.log (toString curPosition) ("x:" ++ (toString ix) ++ " y:" ++ (toString iy))
        -- (toString iy)
    in
        if ix == curPosition.x && iy == curPosition.y then
            not isOn
        else if ix == curPosition.x - 1 && iy == curPosition.y then
            not isOn
        else if ix == curPosition.x && iy == curPosition.y - 1 then
            not isOn
        else if ix == curPosition.x + 1 && iy == curPosition.y then
            not isOn
        else if ix == curPosition.x && iy == curPosition.y + 1 then
            not isOn
        else
            isOn


view model =
    Html.div [ class "container" ]
        [ div [] [ (drawBoard model.isOn) ]
        , Html.hr [] []
        , button [ onClick Restart ] [ text "Restart" ]
        , Html.hr [] []
        , drawWin model
        , Html.hr [] []
        , Html.div [] [ Matrix.Extra.prettyPrint model.isOn ]
        ]


drawWin : Model -> Html Msg
drawWin model =
    if isSolved model then
        h1 [] [ text "Win!!" ]
    else
        div [] []


isSolved : Model -> Bool
isSolved model =
    model.isOn
        |> Matrix.filter ((==) True)
        |> Array.isEmpty


drawBoard : Matrix Bool -> Html Msg
drawBoard isOn =
    let
        drawrow row =
            div
                []
                (Matrix.getRow row isOn
                    |> Maybe.withDefault Array.empty
                    |> Array.indexedMap (cell row)
                    |> Array.toList
                )

        height =
            Matrix.height isOn

        -- Matrix.indexedMap cell model.isOn
    in
        --[0..height] |> drawrow
        List.map drawrow [0..height]
            |> div []



--|> div []


cell : Int -> Int -> Bool -> Html Msg
cell x y isOn =
    Html.div
        [ Html.Attributes.style
            [ ( "background-color"
              , if isOn then
                    "orange"
                else
                    "grey"
              )
            , ( "width", "80px" )
            , ( "height", "80px" )
            , ( "border-radius", "4px" )
            , ( "margin", "2px" )
            , ( "display", "inline-block" )
            ]
        , Html.Events.onClick (Toggle { x = x, y = y })
        ]
        [ text <|
            (toString x)
                ++ ", "
                ++ (toString y)
        ]


main =
    Html.App.beginnerProgram
        { model = init
        , update = update
        , view = view
        }
