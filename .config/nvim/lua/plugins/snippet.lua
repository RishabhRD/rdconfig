return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    config = function()
      local ls = require "luasnip"

      vim.keymap.set({ "i" }, "<C-l>", function()
        ls.expand()
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        ls.jump(1)
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        ls.jump(-1)
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<C-e>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })
      require "rd.snippets.all"
      require "rd.snippets.cpp"
      require "rd.snippets.haskell"
    end,
  },
}
