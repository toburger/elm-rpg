module Players.Update (..) where

import Effects exposing (Effects)
import Hop
import Players.Actions exposing (..)
import Players.Models exposing (..)


update : Action -> Model -> ( List Player, Effects Action )
update action model =
  case action of
    EditPlayer id ->
      let
        path =
          "/players/" ++ (toString id) ++ "/edit"
      in
        ( model.players
        , Effects.map
            HopAction
            (Hop.navigateTo path)
        )

    ListPlayers ->
      let
        path =
          "/players/"
      in
        ( model.players
        , Effects.map
            HopAction
            (Hop.navigateTo path)
        )

    _ ->
      ( model.players, Effects.none )
