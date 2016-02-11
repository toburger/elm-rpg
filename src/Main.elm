module Main (..) where

import Html
import Effects exposing (Effects, Never)
import Task
import StartApp
import Actions exposing (Action)
import Models exposing (..)
import Update exposing (update)
import View exposing (view)


init : ( Model, Effects Action )
init =
  ( initialModel, Effects.none )


app : StartApp.App Model
app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = []
    }


main : Signal.Signal Html.Html
main =
  app.html


port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks
