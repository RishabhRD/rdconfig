return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function()
    local harpoon = require "harpoon"
    harpoon:setup {
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
    }
    vim.keymap.set("n", "<leader>m", function()
      harpoon:list():add()
    end)

    vim.keymap.set("n", "<C-p>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    for i, key in pairs { "j", "k", "l", ";" } do
      vim.keymap.set("n", string.format("<space>%s", key), function()
        harpoon:list():select(i)
      end)
      vim.keymap.set("n", string.format("<space>s%s", key), function()
        harpoon.config.term.select(i, harpoon.config.term.buffers)
      end)
    end
  end,
}
