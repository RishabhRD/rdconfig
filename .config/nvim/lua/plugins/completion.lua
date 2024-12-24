return {
  {
    "saghen/blink.cmp",
    dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
    version = "*",
    opts = {
      completion = {
        list = {
          selection = function(_)
            return "auto_insert"
          end,
        },
        trigger = {
          show_on_insert_on_trigger_character = true,
        },
        menu = {
          auto_show = function(ctx)
            return ctx.mode ~= "cmdline"
          end,
        },
        ghost_text = {
          enabled = false, -- Shows current selection as virtual text
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 300,
        },
      },
      keymap = { preset = "default" },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      signature = { enabled = true },
      snippets = {
        expand = function(snippet)
          require("luasnip").lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction)
          require("luasnip").jump(direction)
        end,
      },
    },
    opts_extend = { "sources.default" },
  },
}
