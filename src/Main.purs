module Main where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Effect.Console (log, logShow)
import Inventory.ApiM (LogLevel(..), runApiM)
import Inventory.Capability.ManageRecipe (addRecipe, getRecipe, getRecipesForUser)

main :: Effect Unit
main = launchAff_ $ 
  runApiM { logLevel: Dev } $ do 
    let newRecipe = { name: "Sazerac", user_id: 1 } 
    res <- addRecipe newRecipe
    recipes <- getRecipesForUser 1
    liftEffect $ logShow res
    liftEffect $ logShow recipes
