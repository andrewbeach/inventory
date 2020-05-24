module Inventory.Data.User where

type UserId = Int 

-- | Base user 
type User_ r = 
  { fname :: String 
  , lname :: String 
  | r
  } 

-- | Unpersisted user 
type User' = User_ ()

-- | Persisted user
type User = User_ 
  ( id :: Int )
  
