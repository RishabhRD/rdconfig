vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append "c"
local cmp = require "cmp"
cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-y>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = false,
    },
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "vsnip" },
    { name = "buffer", max_item_count = 5 },
  },
  sorting = {
    comparators = {
      function(entry1, entry2)
        local types = require "cmp.types"
        local kind1 = entry1:get_kind()
        local kind2 = entry2:get_kind()
        if kind1 ~= kind2 then
          if kind1 == types.lsp.CompletionItemKind.Text then
            return false
          end
          if kind2 == types.lsp.CompletionItemKind.Text then
            return true
          end
        end
        local score1 = entry1.completion_item.score
        local score2 = entry2.completion_item.score
        if score1 and score2 then
          local diff = score1 - score2
          if diff < 0 then
            return false
          elseif diff > 0 then
            return true
          end
        end
      end,

      -- The built-in comparators:
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  formatting = {
    format = require("lspkind").cmp_format {
      with_text = true,
      maxwidth = 55,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        vsnip = "[snip]",
      },
    },
  },
}
