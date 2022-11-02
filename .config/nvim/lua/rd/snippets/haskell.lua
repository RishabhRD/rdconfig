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
        "module Main where",
        "import           Control.Monad (replicateM_)",
        "",
        "parseInt :: String -> Int",
        "parseInt = read",
        "",
        "getWords :: IO [String]",
        "getWords = words <$> getLine",
        "",
        "getInts :: IO [Int]",
        "getInts = fmap (fmap parseInt) getWords",
        "",
        "getInt :: IO Int",
        "getInt = head <$> getInts",
        "",
        "doCase :: IO ()",
        "doCase = do",
        "  return ()",
        "",
        "main :: IO ()",
        "main = getInt >>= flip replicateM_ doCase",
      },
    },
  }
)
