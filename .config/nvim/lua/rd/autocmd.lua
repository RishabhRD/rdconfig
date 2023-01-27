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
  local format = require("rd.autoformat").format
  local lsp = require("rd.lsp-zero").executeLspPreWriteHooks
  local bufWritePreTasks = {
    format,
    lsp,
  }
  makeOrderedAutoGroup("BufWritePreOrdered", "BufWritePre", bufWritePreTasks)
end

return {
  setup = setup,
}
