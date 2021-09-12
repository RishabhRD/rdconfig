local actions = require "telescope.actions"

require("telescope").setup {
  defaults = {
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" },
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    mappings = {
      n = {
        ["q"] = actions.send_to_qflist + actions.open_qflist
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
}
require("telescope").load_extension "fzf"
require("telescope").load_extension "dap"
