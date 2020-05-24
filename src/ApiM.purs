module Inventory.ApiM where 

import Prelude

import Control.Monad.Reader (class MonadAsk, ReaderT, asks, runReaderT)
import Database.Postgres as PG
import Database.Postgres.SqlValue (toSql)
import Effect.Aff (Aff)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect)
import Inventory.Capability.ManageRecipe (class ManageRecipe)
import Inventory.Capability.ManageUser (class ManageUser)
import Inventory.Db as Db
import Type.Equality (class TypeEquals, from)

data LogLevel 
  = Dev
  | Prod 

derive instance eqLogLevel  :: Eq LogLevel 
derive instance ordLogLevel :: Ord LogLevel 

type Env = 
  { logLevel :: LogLevel 
  } 

newtype ApiM a = ApiM (ReaderT Env Aff a) 

runApiM :: Env -> ApiM ~> Aff
runApiM env (ApiM m) = runReaderT m env

derive newtype instance functorApiM     :: Functor ApiM 
derive newtype instance applyApiM       :: Apply ApiM 
derive newtype instance applicativeApiM :: Applicative ApiM 
derive newtype instance bindApiM        :: Bind ApiM 
derive newtype instance monadApiM       :: Monad ApiM 
derive newtype instance monadEffectApiM :: MonadEffect ApiM
derive newtype instance monadAffApiM    :: MonadAff ApiM 

instance monadAskApiM :: TypeEquals e Env => MonadAsk e ApiM where
  ask = ApiM $ asks from 

instance manageRecipeApiM :: ManageRecipe ApiM where 
  getRecipe rid = 
    let q = PG.Query "select id, name, user_id from recipes where id = $1"
    in Db.withPool $ PG.queryOne Db.read q [toSql rid]

  getRecipesForUser uid = 
    let q = PG.Query "select id, name, user_id from recipes where user_id = $1"
    in Db.withPool $ PG.query Db.read q [toSql uid]

  addRecipe recipe_ = 
    let q = PG.Query "insert into recipes (name, user_id) values ($1, $2)"
    in Db.withPool $ PG.query Db.read q [toSql recipe_.name, toSql recipe_.user_id]

  addIngredientToRecipe rid iid parts =     
    let q = PG.Query "insert into ingredients_to_recipes (recipe_id, ingredient_id, parts) values ($1, $2, $3)" 
    in Db.withPool $ PG.execute q (toSql <$> [rid, iid, parts])
                   
instance manageUserApiM :: ManageUser ApiM where 
  saveUser u = 
    let query = PG.Query "insert into users (fname, lname) values ($1, $2)" 
        params = toSql <$> [u.fname, u.lname] 
    in Db.withPool $ PG.query Db.read query params
