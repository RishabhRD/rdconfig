local action_state = require "telescope.actions.state"
local conf = require("telescope.config").values
local pickers = require "telescope.pickers"
local actions = require "telescope.actions"
local finders = require "telescope.finders"

local function colorscheme()
  local opts = {}
  local colors = vim.list_extend(opts.colors or {}, vim.fn.getcompletion("", "color"))
  pickers.new(opts, {
    prompt = "Change Colorscheme",
    finder = finders.new_table {
      results = colors,
    },
    layout_config = {
      width = 0.3,
      height = 0.4,
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()

        actions.close(prompt_bufnr)
        require("rd.colors").colorscheme(selection.value)
      end)

      return true
    end,
  }):find()
end

return colorscheme
