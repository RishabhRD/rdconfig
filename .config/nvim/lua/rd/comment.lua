local comment = require "Comment"

local ft = require "Comment.ft"
ft.c = {'// %s', '/* %s */'}
ft.cpp = {'// %s', '/* %s */'}

comment.setup {
  padding = true,
  sticky = true,
  ignore = nil,

  toggler = {
    line = "gcc",
    block = "gbc",
  },

  opleader = {
    line = "gc",
    block = "gb",
  },

  mappings = {
    basic = true,
    extra = true,
    extended = false,
  },
  pre_hook = nil,
  post_hook = nil,
}
