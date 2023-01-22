if require "rd.packer_download"() then
  return
end

vim.g.mapleader = " "

-- some globals
require "rd.globals"

require "rd.plugins"
require "rd.ui"
require "rd.lsp-zero"
-- Old lsp setup
-- require "rd.lsp"
require "rd.lsp.completion"
require "rd.catppuccino"
require "rd.colors"
require "rd.telescope.setup"
require "rd.telescope.mapper"
require "rd.comment"
require "rd.ts_config"
require "rd.godbolt"
require "rd.indentline"
require "rd.snippets"
require("fidget").setup {}
require "rd.neoformat"
