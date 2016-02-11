module Main (..) where

import Html
import Effects exposing (Effects, Never)
import Task
import StartApp


type alias Model =
  {}


type Action
  = NoOp


initialModel : Model
initialModel =
  {}


view : Signal.Address Action -> Model -> Html.Html
view address model =
  Html.div
    []
    []


update : Action -> Model -> ( Model, Effects Action )
update action model =
  ( model, Effects.none )


app : StartApp.App Model
app =
  StartApp.start
    { init = ( initialModel, Effects.none )
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
