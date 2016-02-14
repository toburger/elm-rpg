module Update (..) where

import Models exposing (..)
import Actions exposing (..)
import Effects exposing (Effects)
import Routing
import Mailboxes exposing (..)
import Players.Update


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case (Debug.log "action" action) of
    RoutingAction subAction ->
      let
        ( updatedRouting, fx ) =
          Routing.update
            subAction
            model.routing
      in
        ( { model | routing = updatedRouting }
        , Effects.map RoutingAction fx
        )

    PlayersAction subAction ->
      let
        updateModel =
          { players = model.players
          , showErrorAddress =
              Signal.forwardTo
                actionsMailbox.address
                ShowError
          }

        ( updatedPlayers, fx ) =
          Players.Update.update
            subAction
            updateModel
      in
        ( { model | players = updatedPlayers }
        , Effects.map PlayersAction fx
        )

    ShowError message ->
      ( { model | errorMessage = message }, Effects.none )

    NoOp ->
      ( model, Effects.none )
