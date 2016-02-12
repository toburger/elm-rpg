module View (..) where

import Html exposing (..)
import Actions exposing (..)
import Models exposing (..)
import Players.List
import Players.Edit
import Dict
import Routing


view : Signal.Address Action -> Model -> Html
view address model =
  let
    _ =
      Debug.log "model" model
  in
    div
      []
      [ page address model ]


page : Signal.Address Action -> Model -> Html
page address model =
  case model.routing.view of
    Routing.PlayersView ->
      let
        viewModel =
          { players = model.players
          }
      in
        Players.List.view
          (Signal.forwardTo
            address
            PlayersAction
          )
          viewModel

    Routing.PlayerEditView ->
      let
        playerId =
          model.routing.routerPayload.params
            |> Dict.get "id"
            |> Maybe.withDefault ""

        maybePlayer =
          model.players
            |> List.filter (\player -> (toString player.id) == playerId)
            |> List.head
      in
        case maybePlayer of
          Just player ->
            let
              viewModel =
                { player = player }
            in
              Players.Edit.view
                (Signal.forwardTo address PlayersAction)
                viewModel

          Nothing ->
            notFoundView

    Routing.NotFoundView ->
      notFoundView


notFoundView : Html
notFoundView =
  div
    []
    [ text "Not found" ]
