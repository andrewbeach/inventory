module Inventory.Capability.ManageUser where 

import Prelude

import Inventory.Data.User (User, User')

class Monad m <= ManageUser m where
  saveUser :: User' -> m (Array User)
