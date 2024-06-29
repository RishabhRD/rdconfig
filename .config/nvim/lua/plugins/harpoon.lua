return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function()
    local harpoon = require "harpoon"
    harpoon:setup {
      term = {
        select = function(n)
          P(n)
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
        harpoon.config.term.select(i)
      end)
    end
  end,
}
