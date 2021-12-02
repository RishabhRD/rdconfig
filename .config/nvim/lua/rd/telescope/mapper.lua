local nnoremap = vim.keymap.nnoremap

TelescopeMapArgs = TelescopeMapArgs or {}
local map_tele = function(key, f, options, buffer)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}

  local mode = "n"
  local rhs = string.format("<cmd>lua require('rd.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

  local map_options = {
    noremap = true,
    silent = true,
  }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  end
end

map_tele("<leader>ff", "find_files")
nnoremap { "<leader>fL", ":Rg<CR>" }
map_tele("<leader>fl", "live_grep")
map_tele("<leader>fk", "current_buffer_fuzzy_find")
map_tele("<leader>fb", "buffers")
map_tele("<leader>fT", "builtin")
map_tele("<leader>fo", "file_browser")
map_tele("<leader>fm", "man")
map_tele("<C-y>", "colorscheme")
map_tele("<A-y>", "help_tags")
nnoremap { "<leader>ft", ":TodoTelescope<CR>" }
map_tele("<leader>gb", "git_branches")
nnoremap { "<leader>fg", [[:lua require("telescope").extensions.live_grep_raw.live_grep_raw()<CR>]] }

return map_tele
