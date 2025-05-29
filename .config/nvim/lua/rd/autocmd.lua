local function makeOrderedAutoGroup(name, cmd, tasks)
  local function runTasks()
    for _, v in ipairs(tasks) do
      v()
    end
  end
  local augroup_name = name
  local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })
  vim.api.nvim_create_autocmd({ cmd }, {
    callback = runTasks,
    group = group,
  })
end

local function setup()
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    desc = "Hightlight selection on yank",
    pattern = "*",
    callback = function()
      vim.highlight.on_yank { higroup = "IncSearch", timeout = 50 }
    end,
  })
  local format = require("rd.autoformat").format

  -- Swift support is bad with treesitter.
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "swift",
    callback = function()
      vim.opt_local.cindent = true
      vim.opt_local.shiftwidth = 2
      vim.opt_local.softtabstop = 2
      vim.opt_local.expandtab = true

      -- Enable continuation of comments when pressing Enter or o/O
      vim.opt_local.formatoptions:append "r"
      vim.opt_local.formatoptions:append "o"

      -- Set comments for:
      -- s1:/*   - start of block comment
      -- mb:*    - middle of block comment
      -- ex:*/   - end of block comment
      -- ://     - line comment
      -- :///    - doc line comment (triple slash)
      -- s2:/**  - start of doc block comment
      vim.opt_local.comments = "s1:/*,mb:*,ex:*/,:///,://,s2:/**"
    end,
  })

  local lsp = require("rd.lsp").executeLspPreWriteHooks
  local bufWritePreTasks = {
    format,
    lsp,
  }
  makeOrderedAutoGroup("BufWritePreOrdered", "BufWritePre", bufWritePreTasks)
end

return {
  setup = setup,
}
