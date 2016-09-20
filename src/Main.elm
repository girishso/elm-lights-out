--module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Html.App exposing (beginnerProgram)
import Matrix exposing (..)
import Matrix.Extra exposing (..)
import Array exposing(..)

type alias Player =  Maybe String

type alias Model =
    {
    isOn : Bool
    , currentPlayer: Player
    , players: List Player
    }


init =
    {
    isOn = True
    , currentPlayer = Just "A"
    , players = [Just "A", Just "B"]
    }


type Msg
    = Toggle

update : Msg -> Model -> Model
update msg model =
  let
    chooseNextPlayer : Player -> List Player -> Player
    chooseNextPlayer current players =
      let
        p = List.filter (\x -> x /= current) players
        |> List.head
      in
        case p of
          Just p -> p
          Nothing -> Just ""
  in
    case msg of
        Toggle ->
            { model | isOn = not model.isOn, currentPlayer = chooseNextPlayer model.currentPlayer model.players }


view model =
    Html.div []
        [ Html.div
            [ Html.Attributes.style
                [ ( "background-color"
                  , if model.isOn then
                        "orange"
                    else
                        "grey"
                  )
                , ( "width", "80px" )
                , ( "height", "80px" )
                , ( "border-radius", "4px" )
                , ( "margin", "2px" )
                ]
            , Html.Events.onClick Toggle
            ]
            []
        , Html.hr [] []
        , Html.h2 [] [Html.text ("currentPlayer: " ++ showCurrentPlayer model.currentPlayer)]
        , Html.pre [] [ Html.text <| toString model ]
        ]

showCurrentPlayer : Player -> String
showCurrentPlayer player =
  case player of
    Just player -> player
    Nothing -> ""

main =
    Html.App.beginnerProgram
        { model = init
        , update = update
        , view = view
        }
