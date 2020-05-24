module Inventory.Db where

import Prelude

import Data.Bifunctor (lmap)
import Data.Either (Either)
import Database.Postgres (Client, ClientConfig, ConnectionInfo)
import Database.Postgres as PG
import Effect.Aff (Aff, Error, error)
import Effect.Aff.Class (class MonadAff, liftAff)
import Effect.Class (liftEffect)
import Foreign (Foreign)
import Simple.JSON as JSON

clientConfig :: ClientConfig 
clientConfig = 
  { host: "localhost" 
  , database: "cocktails" 
  , port: 5432
  , user: "andrewbeach"
  , password: "abc123" 
  , ssl: false
  } 

connectionInfo :: ConnectionInfo
connectionInfo = PG.connectionInfoFromConfig clientConfig PG.defaultPoolConfig

read :: forall a. JSON.ReadForeign a => Foreign -> Either Error a
read = lmap (error <<< show) <<< JSON.read

withPool :: forall m a. MonadAff m => (Client -> Aff a) -> m a  
withPool f = do 
  pool <- liftEffect $ PG.mkPool connectionInfo 
  liftAff $ PG.withClient pool f

