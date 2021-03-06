module Players.Edit (..) where

import Html exposing (..)
import Html.Attributes exposing (class, value)
import Html.Events exposing (onClick)
import Players.Models exposing (..)
import Perks.Models exposing (Perk)
import PerksPlayers.Models exposing (PerkPlayer)
import Players.Actions exposing (..)
import PerksPlayers.Utils exposing (bonusesForPlayerId)


type alias ViewModel =
  { player : Player
  , perks : List Perk
  , perksPlayers : List PerkPlayer
  }


listBtn : Signal.Address Action -> ViewModel -> Html
listBtn address model =
  button
    [ class "btn regular"
    , onClick address ListPlayers
    ]
    [ i [ class "fa fa-chevron-left mr1" ] []
    , text "List"
    ]


view : Signal.Address Action -> ViewModel -> Html
view address model =
  div
    []
    [ nav address model
    , form address model
    ]


nav : Signal.Address Action -> ViewModel -> Html
nav address model =
  div
    [ class "clearfix mb2 white bg-black p1" ]
    [ listBtn address model ]


form : Signal.Address Action -> ViewModel -> Html
form address model =
  let
    bonuses =
      bonusesForPlayerId
        model.perksPlayers
        model.perks
        model.player.id

    strength =
      model.player.level + bonuses
  in
    div
      [ class "m3" ]
      [ h1 [] [ text model.player.name ]
      , formLevel address model
      , formBonuses bonuses
      , formStrength strength
      , formName address model
      , formPerks address model
      ]


formLevel : Signal.Address Action -> ViewModel -> Html
formLevel address model =
  div
    [ class "clearfix py1" ]
    [ div
        [ class "col col-5" ]
        [ text "Level" ]
    , div
        [ class "col col-7" ]
        [ span
            [ class "h2 bold" ]
            [ text (toString model.player.level) ]
        , btnLevelDecrease address model
        , btnLevelIncrease address model
        ]
    ]


btnLevelDecrease : Signal.Address Action -> ViewModel -> Html
btnLevelDecrease address model =
  a
    [ class "btn ml1 h1" ]
    [ i
        [ class "fa fa-minus-circle" ]
        []
    ]


btnLevelIncrease : Signal.Address Action -> ViewModel -> Html
btnLevelIncrease address model =
  a
    [ class "btn ml1 h1" ]
    [ i
        [ class "fa fa-plus-circle" ]
        []
    ]


formBonuses : Int -> Html
formBonuses bonuses =
  div
    [ class "clearfix py1" ]
    [ div
        [ class "col col-5" ]
        [ text "Bonuses" ]
    , div
        [ class "col col-7 h2" ]
        [ text (toString bonuses) ]
    ]


formStrength : Int -> Html
formStrength strength =
  div
    [ class "clearfix py1" ]
    [ div
        [ class "col col-5" ]
        [ text "Strength" ]
    , div
        [ class "col col-7 h2 bold" ]
        [ text (toString strength) ]
    ]


formName : Signal.Address Action -> ViewModel -> Html
formName address model =
  div
    [ class "clearfix py1" ]
    [ div
        [ class "col col-5" ]
        [ text "Name" ]
    , div
        [ class "col col-7" ]
        [ inputName address model ]
    ]


inputName : Signal.Address Action -> ViewModel -> Html
inputName address model =
  input
    [ class "field-light"
    , value model.player.name
    ]
    []


formPerks : Signal.Address Action -> ViewModel -> Html
formPerks address model =
  div
    [ class "clearfix py1" ]
    [ div
        [ class "col col-5" ]
        [ text "Perks" ]
    , div
        [ class "col col-7" ]
        []
    ]
