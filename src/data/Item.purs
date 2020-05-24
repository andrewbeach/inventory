module Inventory.Data.Item 
  ( Item 
  , ItemId 
  , Quantity
  , Unit 
  , UnitId
  , itemId 
  , unitId 
  ) where 

import Prelude

type Quantity = Number

type UnitId = Int 
unitId :: Int -> UnitId 
unitId = identity 

type Unit = 
  { id   :: UnitId 
  , name :: String 
  } 
  
type ItemId = Int
itemId :: Int -> ItemId 
itemId = identity

type Item = 
  { id       :: ItemId 
  , name     :: String 
  , quantity :: Quantity 
  , unit_id  :: Int
  } 

