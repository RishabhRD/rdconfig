local nmap = require("std").nmap

vim.pack.add({
  "https://github.com/tpope/vim-surround",
  "https://github.com/tpope/vim-scriptease",
  "https://github.com/romainl/vim-qf",
  "https://github.com/lambdalisue/vim-protocol",
  "https://github.com/tpope/vim-repeat",
  "https://github.com/godlygeek/tabular",
  "https://github.com/vim-utils/vim-man",
  "https://github.com/NStefan002/screenkey.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-lua/plenary.nvim",
  { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/folke/snacks.nvim",
})

local harpoon = require("harpoon")

harpoon:setup({
  term = {
    buffers = {},
    select = function(n, buffers)
      local bufnr = buffers[n] or -1
      local is_valid_buf = vim.api.nvim_buf_is_valid(bufnr)
      if not is_valid_buf then
        bufnr = vim.api.nvim_create_buf(false, false)
      end
      local win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_buf(win, bufnr)
      if not is_valid_buf then
        vim.fn.termopen(vim.o.shell)
      end
      buffers[n] = bufnr
    end,
  },
  settings = {
    save_on_toggle = true,
  },
})

vim.keymap.set("n", "<leader>m", function()
  harpoon:list():add()
end)

vim.keymap.set("n", "<C-p>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

for i, key in pairs({ "j", "k", "l", ";" }) do
  vim.keymap.set("n", string.format("<space>%s", key), function()
    harpoon:list():select(i)
  end)
  vim.keymap.set("n", string.format("<space>s%s", key), function()
    harpoon.config.term.select(i, harpoon.config.term.buffers)
  end)
end

CustomOilBar = function()
  local path = vim.fn.expand("%")
  path = path:gsub("oil://", "")

  return "  " .. vim.fn.fnamemodify(path, ":.")
end

require("oil").setup({
  columns = {
    "icon",
  },
  view_options = {
    show_hidden = true,
  },
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

require("snacks").setup({
  input = { enabled = true },
  picker = { enabled = true, ui_select = true },
})

vim.api.nvim_create_autocmd("User", {
  pattern = "OilActionsPost",
  callback = function(event)
    if event.data.actions[1].type == "move" then
      Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
    end
  end,
})

nmap("<leader>ff", Snacks.picker.files)
nmap("<leader>fl", Snacks.picker.grep)
nmap("<leader>ft", Snacks.picker.pickers)
nmap("<C-y>", Snacks.picker.colorschemes)
nmap("<A-y>", Snacks.picker.help)

nmap("<leader>gs", ":Git<CR>")
nmap("<leader>gc", ":Git commit<CR>")
