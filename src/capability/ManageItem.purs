module Inventory.Capability.ManageItem where

import Prelude

import Inventory.Data.Item (Item)

class Monad m <= ManageItem m where 
  getItems :: m (Array Item)
