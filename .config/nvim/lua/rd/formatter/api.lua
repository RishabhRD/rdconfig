local Job = require "plenary.job"
local M = {}

M.format_with_cmd = function(cmd_table, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  cmd_table = cmd_table or {}
  cmd_table.writer = vim.api.nvim_buf_get_lines(0, 0, -1, false)


  local j = Job:new(cmd_table)
  local output = j:sync()

  if j.code ~= 0 then
    -- Schedule this so that it doesn't do dumb stuff like printing two things.
    vim.schedule(function()
      print "Failed to process due to errors"
    end)

    return
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, output)
end

return M
