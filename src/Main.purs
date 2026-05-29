module Main where

import Prelude

import App.Game as Game
import Effect (Effect)
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)
import Effect.Class (liftEffect)

main :: Effect Unit
main = HA.runHalogenAff do
  body <- HA.awaitBody
  component <- liftEffect Game.mkComponent
  runUI component unit body
