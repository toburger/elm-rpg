module Players.List (..) where

import Html exposing (..)
import Html.Attributes exposing (class)
import Players.Actions exposing (..)
import Players.Models exposing (Player, Model)


view : Signal.Address Action -> Model -> Html
view address model =
  div
    []
    [ div
        [ class "right-align" ]
        []
    , table
        [ class "table-light" ]
        [ thead
            []
            [ tr
                []
                [ th [] [ text "Id " ]
                , th [] [ text "Name" ]
                , th [] [ text "Level" ]
                , th [] [ text "Bonus" ]
                , th [] [ text "Strength" ]
                , th [] [ text "Actions" ]
                ]
            ]
        , tbody [] (List.map (playerRow address model) model.players)
        ]
    ]


playerRow : Signal.Address Action -> Model -> Player -> Html
playerRow address model player =
  let
    bonuses =
      999

    strength =
      bonuses + player.level
  in
    tr
      []
      [ td [] [ text (toString player.id) ]
      , td [] [ text (toString player.name) ]
      , td [] [ text (toString player.level) ]
      , td [] [ text (toString bonuses) ]
      , td [] [ text (toString strength) ]
      , td [] []
      ]