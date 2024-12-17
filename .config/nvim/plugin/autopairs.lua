local ns_id = vim.api.nvim_create_namespace "autopair_virtual_text"
local ts_utils = require "nvim-treesitter.ts_utils"

-- Renamed 'pairs' to 'pair_map' to avoid conflict
local pair_map = {
  ["("] = ")",
  ["{"] = "}",
  ["["] = "]",
  ["<"] = ">",
  ['"'] = '"',
  ["'"] = "'",
}

local function count_unmatched_openings(line, opening, closing)
  local open_count = 0
  for char in line:gmatch("[%" .. opening .. "%" .. closing .. "]") do
    if char == opening then
      open_count = open_count + 1
    elseif char == closing then
      open_count = open_count - 1
    end
  end
  return math.max(0, open_count)
end

local function is_in_string_or_comment()
  local node = ts_utils.get_node_at_cursor()
  while node do
    local type = node:type()
    if type == "string" or type == "comment" then
      return true
    end
    node = node:parent()
  end
  return false
end

local function show_virtual_pair()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local buf = vim.api.nvim_get_current_buf()
  local current_line = vim.api.nvim_get_current_line()

  -- Clear existing virtual text
  vim.api.nvim_buf_clear_namespace(buf, ns_id, 0, -1)

  -- Stop if we're in a string or comment
  if is_in_string_or_comment() then
    return
  end

  -- Check if there are unmatched opening pairs
  for opening, closing in pairs(pair_map) do
    local unmatched_count = count_unmatched_openings(current_line:sub(1, col), opening, closing)

    -- If the unmatched count is greater than 0, suggest closing pair at the end of the line
    if unmatched_count > 0 then
      -- Check if the closing pair already exists at the cursor position
      local char_at_cursor = current_line:sub(col + 1, col + 1)
      if char_at_cursor == closing then
        unmatched_count = unmatched_count - 1
      end

      -- Show virtual text at the end of the line if there are unmatched pairs
      if unmatched_count > 0 then
        local virt_text = string.rep(closing, unmatched_count)
        vim.api.nvim_buf_set_extmark(buf, ns_id, line - 1, #current_line, {
          virt_text = { { virt_text, "Comment" } },
          virt_text_pos = "overlay",
          hl_mode = "combine",
        })
        return
      end
    end
  end
end

-- Autocommands for showing virtual text dynamically
vim.api.nvim_create_autocmd({ "CursorMovedI", "TextChangedI" }, {
  callback = show_virtual_pair,
  desc = "Show virtual pairing characters dynamically",
})

-- Clear virtual text when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
  end,
  desc = "Clear virtual pairing characters",
})
