module Routing (..) where

import Effects exposing (Effects, Never)
import Hop


type Action
  = HopAction Hop.Action
  | ShowPlayers Hop.Payload
  | ShowPlayerEdit Hop.Payload
  | ShowNotFound Hop.Payload
  | NavigateTo String
  | NoOp


type AvailableViews
  = PlayersView
  | PlayerEditView
  | NotFoundView


type alias Model =
  { routerPayload : Hop.Payload
  , view : AvailableViews
  }


initialModel : Model
initialModel =
  { routerPayload = router.payload
  , view = PlayersView
  }


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    NavigateTo path ->
      ( model
      , Effects.map
          HopAction
          (Hop.navigateTo path)
      )

    ShowPlayers payload ->
      ( { model
          | view = PlayersView
          , routerPayload = payload
        }
      , Effects.none
      )

    ShowPlayerEdit payload ->
      ( { model
          | view = PlayerEditView
          , routerPayload = payload
        }
      , Effects.none
      )

    _ ->
      ( model, Effects.none )


routes : List ( String, Hop.Payload -> Action )
routes =
  [ ( "/", ShowPlayers )
  , ( "/players", ShowPlayers )
  , ( "/players/:id/edit", ShowPlayerEdit )
  ]


router : Hop.Router Action
router =
  Hop.new
    { routes = routes
    , notFoundAction = ShowNotFound
    }
