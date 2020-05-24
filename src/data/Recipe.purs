module Inventory.Data.Recipe where

import Inventory.Data.User (UserId)

type RecipeId = Int 

-- | Base Recipe 
type Recipe_ r = 
  { name    :: String 
  , user_id :: UserId 
  | r
  } 

-- | Unpersisted Recipe
type Recipe' = Recipe_ ()

-- | Extends Recipe base with id and other persistence-related metadata
type Recipe = Recipe_ 
  ( id :: RecipeId ) 
