if require "rd.packer_download"() then
  return
end

vim.g.mapleader = " "

-- some globals
require "rd.globals"

require "rd.plugins"
-- force astronauta to load first
vim.cmd [[runtime plugin/astronauta.vim]]
require "rd.ui"
require "rd.lsp"
require "rd.catppuccino"
require "rd.colors"
require "rd.telescope.setup"
require "rd.telescope.mapper"
require "rd.comment"
require "rd.ts_config"
require "rd.godbolt"
require "rd.indentline"
require "rd.indentline"
