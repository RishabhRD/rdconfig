pcall(require, "luarocks.loader")
require("global").setup()
require("error").setup()
require "keybinds"
require("mouse").setup()
require("rules").setup()
require("signal").setup()
require("apps").setup()
