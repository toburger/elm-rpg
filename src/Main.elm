module Main (..) where

import Html
import Effects exposing (Effects, Never)
import Task
import StartApp
import Actions exposing (Action(..))
import Models exposing (..)
import Update exposing (update)
import View exposing (view)
import Routing exposing (router)
import Mailboxes exposing (..)
import Players.Effects
import Perks.Effects
import PerksPlayers.Effects


routerSignal : Signal Action
routerSignal =
  Signal.map RoutingAction router.signal


init : ( Model, Effects Action )
init =
  let
    fxs =
      [ Effects.map
          PlayersAction
          Players.Effects.fetchAll
      , Effects.map
          PerksAction
          Perks.Effects.fetchAll
      , Effects.map
          PerksPlayersAction
          PerksPlayers.Effects.fetchAll
      ]

    fx =
      Effects.batch fxs
  in
    ( initialModel, fx )


app : StartApp.App Model
app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = [ routerSignal, actionsMailbox.signal ]
    }


main : Signal.Signal Html.Html
main =
  app.html


port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks


port routeRunTask : Task.Task () ()
port routeRunTask =
  router.run
