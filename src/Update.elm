module Update (..) where

import Models exposing (..)
import Actions exposing (..)
import Effects exposing (Effects)
import Players.Update


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    PlayersAction subAction ->
      let
        updateModel =
          { players = model.players }

        ( updatedPlayers, fx ) =
          Players.Update.update
            subAction
            updateModel
      in
        ( { model | players = updatedPlayers }
        , Effects.none
        )

    NoOp ->
      ( model, Effects.none )
