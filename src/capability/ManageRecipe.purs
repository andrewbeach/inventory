module Inventory.Capability.ManageRecipe where 

import Prelude

import Data.Maybe (Maybe)
import Inventory.Data.Ingredient (IngredientId)
import Inventory.Data.Recipe (Recipe, RecipeId, Recipe')
import Inventory.Data.User (UserId)

class Monad m <= ManageRecipe m where
  getRecipe             :: RecipeId -> m (Maybe Recipe) 
  getRecipesForUser     :: UserId -> m (Array Recipe) 
  addRecipe             :: Recipe' -> m (Array Recipe) 
  addIngredientToRecipe :: RecipeId -> IngredientId -> Int -> m Unit 
