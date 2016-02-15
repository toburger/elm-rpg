module PerksPlayers.Utils (..) where

import Players.Models exposing (PlayerId)
import Perks.Models exposing (PerkId, Perk)
import PerksPlayers.Models exposing (PerkPlayerId, PerkPlayer)


perkIdsForPlayerId : List PerkPlayer -> PlayerId -> List PerkId
perkIdsForPlayerId perksPlayers playerId =
  perksPlayers
    |> List.filter (\perkPlayer -> perkPlayer.playerId == playerId)
    |> List.map .perkId


perksForPlayerId : List PerkPlayer -> List Perk -> PlayerId -> List Perk
perksForPlayerId perksPlayers perks playerId =
  let
    perkIds =
      perkIdsForPlayerId perksPlayers playerId

    included perk =
      List.any ((==) perk.id) perkIds
  in
    perks
      |> List.filter included


bonusesForPlayerId : List PerkPlayer -> List Perk -> PlayerId -> Int
bonusesForPlayerId perksPlayers perks playerId =
  perksForPlayerId perksPlayers perks playerId
    |> List.foldl (\perk acc -> acc + perk.bonus) 0
