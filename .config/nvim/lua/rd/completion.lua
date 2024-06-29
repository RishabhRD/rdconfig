local cmp = require "cmp"

local function setup()
  vim.opt.completeopt = { "menu", "menuone", "noselect" }
  vim.opt.shortmess:append "c"

  cmp.setup {
    sources = {
      { name = "nvim_lsp" },
      { name = "cody" },
      { name = "path" },
      { name = "buffer" },
      { name = "nvim_lua" },
      { name = "luasnip" },
    },
    mapping = {
      ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
      ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      ["<C-y>"] = cmp.mapping(
        cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        },
        { "i", "c" }
      ),
      ["<C-Space>"] = cmp.mapping.complete(),
    },

    -- Enable luasnip to handle snippet expansion for nvim-cmp
    snippet = {
      expand = function(args)
        vim.snippet.expand(args.body)
      end,
    },
  }
end

return {
  setup = setup,
}
