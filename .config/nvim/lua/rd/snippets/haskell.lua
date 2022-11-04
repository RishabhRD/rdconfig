local ls = require "luasnip"
local api = require "rd.snippets.api"
local make = api.make
local t = api.t
local c = api.ch

ls.add_snippets(
  "haskell",
  make {
    cf = {
      t {
        "-- pragmas.hs {{{",
        "-- vim: foldmethod=marker",
        "{-# LANGUAGE AllowAmbiguousTypes        #-}",
        "{-# LANGUAGE BinaryLiterals             #-}",
        "{-# LANGUAGE ConstraintKinds            #-}",
        "{-# LANGUAGE DataKinds                  #-}",
        "{-# LANGUAGE DeriveFoldable             #-}",
        "{-# LANGUAGE DeriveFunctor              #-}",
        "{-# LANGUAGE DeriveGeneric              #-}",
        "{-# LANGUAGE DeriveTraversable          #-}",
        "{-# LANGUAGE FlexibleContexts           #-}",
        "{-# LANGUAGE FlexibleInstances          #-}",
        "{-# LANGUAGE GeneralizedNewtypeDeriving #-}",
        "{-# LANGUAGE InstanceSigs               #-}",
        "{-# LANGUAGE LambdaCase                 #-}",
        "{-# LANGUAGE MagicHash                  #-}",
        "{-# LANGUAGE MultiParamTypeClasses      #-}",
        "{-# LANGUAGE MultiWayIf                 #-}",
        "{-# LANGUAGE RankNTypes                 #-}",
        "{-# LANGUAGE RecordWildCards            #-}",
        "{-# LANGUAGE ScopedTypeVariables        #-}",
        "{-# LANGUAGE StandaloneDeriving         #-}",
        "{-# LANGUAGE TupleSections              #-}",
        "{-# LANGUAGE TypeApplications           #-}",
        "{-# LANGUAGE TypeFamilies               #-}",
        "{-# LANGUAGE TypeInType                 #-}",
        "{-# LANGUAGE TypeOperators              #-}",
        "{-# LANGUAGE UnboxedTuples              #-}",
        "{-# LANGUAGE UndecidableInstances       #-}",
        "-- pragmas.hs }}}",
        "module Main where",
        "",
        "import           Control.Monad         (replicateM_)",
        "import qualified Data.ByteString.Char8 as C",
        "import           Data.List             (unfoldr)",
        "import           Data.Array (Array, (!))",
        "import           Data.Ix    (Ix)",
        "",
        "docase :: IO ()",
        "docase = do",
        "    return ()",
        "",
        "main :: IO ()",
        "main = getInt >>= flip replicateM_ docase",
        "",
        "readInt :: C.ByteString -> Int",
        "readInt s = let Just (i,_) = C.readInt s in i :: Int",
        "",
        "readInt2 :: C.ByteString -> (Int, Int)",
        "readInt2 u = (a, b)",
        "  where",
        "  Just (a,v) = C.readInt u",
        "  Just (b,_) = C.readInt (C.tail v)",
        "",
        "readInts :: C.ByteString -> [Int]",
        "readInts = unfoldr go where",
        "    go s = do",
        "        (n,s1) <- C.readInt s",
        "        let s2 = C.dropWhile (==' ') s1",
        "        pure (n,s2)",
        "",
        "getInt :: IO Int",
        "getInt  = readInt <$> C.getLine",
        "",
        "getInt2 :: IO (Int, Int)",
        "getInt2 = readInt2 <$> C.getLine",
        "",
        "getInts :: IO [Int]",
        "getInts = readInts <$> C.getLine",
      },
    },
    lex = {
      t {
        "{-# LANGUAGE TupleSections #-}",
      },
    },
    bs = {
      t {
        "class (Ix a) => Indexable f a b where",
        "  atIdx :: f a b -> a -> b",
        "",
        "instance Ix a => Indexable Array a b where",
        "  atIdx :: Ix a => Array a b -> a -> b",
        "  atIdx = (!)",
        "",
        "data Function a b = Function (a -> b)",
        "",
        "instance Ix a => Indexable Function a b where",
        "  atIdx :: Ix a => Function a b -> a -> b",
        "  atIdx (Function f) = f",
        "",
        "partitionPoint :: (Enum a, Indexable f a b) => a -> a -> (b -> Bool) -> f a b -> a",
        "-- range: [low, high)",
        "-- returns index of first element that doesn't satisfy predicate",
        "partitionPoint low' high' isCandidate range = bs low' high'",
        "  where",
        "  bs low high",
        "    | low == high = low",
        "    | isCandidate (atIdx range mid) = bs (next mid) high",
        "    | otherwise = bs low mid",
        "    where mid = toEnum $ (fromEnum low + fromEnum high) `div` 2",
        "  next x = toEnum $ fromEnum x + 1",
        "",
        "lowerBound :: (Enum a, Indexable f a b, Ord b) => a -> a -> b -> f a b -> a",
        "lowerBound low high n = partitionPoint low high (<n)",
        "",
        "upperBound :: (Enum a, Indexable f a b, Ord b) => a -> a -> b -> f a b -> a",
        "upperBound low high n = partitionPoint low high (<=n)",
      },
    },
  }
)
