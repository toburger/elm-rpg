module Players.Update (..) where

import Effects exposing (Effects)
import Players.Actions exposing (..)
import Players.Models exposing (..)


update : Action -> Model -> ( List Player, Effects Action )
update action model =
  ( model.players, Effects.none )
