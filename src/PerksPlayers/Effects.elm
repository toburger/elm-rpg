module PerksPlayers.Effects (..) where

import Effects exposing (Effects)
import Http
import Json.Decode as Decode exposing ((:=))
import Task
import PerksPlayers.Models exposing (PerkPlayer)
import PerksPlayers.Actions as Actions


fetchAllUrl : String
fetchAllUrl =
  "http://localhost:4000/perks_players"


memberDecoder : Decode.Decoder PerkPlayer
memberDecoder =
  Decode.object3
    PerkPlayer
    ("id" := Decode.int)
    ("perkId" := Decode.int)
    ("playerId" := Decode.int)


collectionDecoder : Decode.Decoder (List PerkPlayer)
collectionDecoder =
  Decode.list memberDecoder


fetchAll : Effects Actions.Action
fetchAll =
  Http.get collectionDecoder fetchAllUrl
    |> Task.toResult
    |> Task.map Actions.FetchAllDone
    |> Effects.task
