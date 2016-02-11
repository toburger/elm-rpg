module Update (..) where

import Models exposing (..)
import Actions exposing (..)
import Effects exposing (Effects)


update : Action -> Model -> ( Model, Effects Action )
update action model =
  ( model, Effects.none )
