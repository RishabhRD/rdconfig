local from_entry = require "telescope.from_entry"
local action_state = require "telescope.actions.state"
local actions = require "telescope.actions"
local M = {}

local function file_entry_to_qf(entry)
  return {
    filename = from_entry.path(entry, false),
    lnum = 1,
  }
end

local function send_file_to_qf_list(prompt_bufnr, mode, target)
  mode = mode or "r"
  target = target or "qflist"
  local picker = action_state.get_current_picker(prompt_bufnr)
  local manager = picker.manager
  local qf_entries = {}
  for entry in manager:iter() do
    table.insert(qf_entries, file_entry_to_qf(entry))
  end
  actions.close(prompt_bufnr)

  if target == "loclist" then
    vim.fn.setloclist(picker.original_win_id, qf_entries, mode)
  else
    vim.fn.setqflist(qf_entries, mode)
  end
  actions.open_qflist(prompt_bufnr)
end

M.find_files = function()
  require("telescope.builtin").find_files {
    attach_mappings = function(prompt_bufnr, map)
      map("n", "q", function()
        send_file_to_qf_list(prompt_bufnr)
      end)
      map("i", "<C-q>", function()
        send_file_to_qf_list(prompt_bufnr)
      end)
      return true
    end,
    layout_strategy = "bottom_pane",
  }
end

return setmetatable({}, {
  __index = function(_, k)
    local has_custom, custom = pcall(require, string.format("rd.telescope.custom.%s", k))

    if M[k] then
      return M[k]
    elseif has_custom then
      return custom
    else
      return require("telescope.builtin")[k]
    end
  end,
})
