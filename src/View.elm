module View (..) where

import Actions exposing (Action)
import Models exposing (Model)
import Html


view : Signal.Address Action -> Model -> Html.Html
view address model =
  Html.div
    []
    []
