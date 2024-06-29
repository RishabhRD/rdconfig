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
