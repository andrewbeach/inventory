module Inventory.Data.Ingredient where

import Prelude

import Inventory.Data.Recipe (RecipeId)

type IngredientId = Int

ingredientId :: Int -> IngredientId 
ingredientId = identity

type Ingredient = 
  { id        :: IngredientId 
  , name      :: String 
  , parts     :: Int 
  , recipe_id :: RecipeId
  } 

