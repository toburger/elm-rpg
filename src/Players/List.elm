module Players.List (..) where

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Players.Actions exposing (..)
import Players.Models exposing (Player, Model)
import Perks.Models exposing (Perk)
import PerksPlayers.Models exposing (PerkPlayer)
import PerksPlayers.Utils exposing (bonusesForPlayerId)


type alias ViewModel =
  { players : List Player
  , perks : List Perk
  , perksPlayers : List PerkPlayer
  }


editBtn : Signal.Address Action -> Player -> Html
editBtn address player =
  button
    [ class "btn regular"
    , onClick address (EditPlayer player.id)
    ]
    [ i [ class "fa fa-pencil mr1" ] []
    , text "Edit"
    ]


view : Signal.Address Action -> ViewModel -> Html
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


playerRow : Signal.Address Action -> ViewModel -> Player -> Html
playerRow address model player =
  let
    bonuses =
      bonusesForPlayerId
        model.perksPlayers
        model.perks
        player.id

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
      , td [] [ editBtn address player ]
      ]
