module Inventory.Data.Recipe where

import Inventory.Data.User (UserId)

type RecipeId = Int 

-- | Unpersisted recipe base 
type Recipe_ r = 
  { name    :: String 
  , user_id :: UserId 
  | r
  } 

-- | Extends Recipe base with id and other persistence-related metadata
type Recipe = Recipe_ 
  ( id :: RecipeId ) 
