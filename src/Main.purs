module Main where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Effect.Console (logShow)
import Inventory.ApiM (LogLevel(..), runApiM)
import Inventory.Capability.ManageRecipe (getRecipesForUser)

main :: Effect Unit
main = launchAff_ $ 
  runApiM { logLevel: Dev } $ do 
    recipes <- getRecipesForUser 1
    liftEffect $ logShow recipes
