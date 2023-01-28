if require "rd.packer_download"() then
  return
end

vim.g.mapleader = " "

-- some globals
require "rd.globals"

require "rd.plugins"
require("rd.lsp-zero").setup()
-- Old lsp setup
-- require "rd.lsp"
require "rd.lsp.completion"
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
require("rd.autoformat").setup()
require "rd.dressing"
require "rd.compitest"
require("rd.autocmd").setup()
-- require "rd.noice"
