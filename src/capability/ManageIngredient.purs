module Inventory.Capability.ManageIngredient where 

import Prelude 

import Inventory.Data.Ingredient (Ingredient)

class Monad m <= ManageItem m where 
  getItems :: m (Array Ingredient)
