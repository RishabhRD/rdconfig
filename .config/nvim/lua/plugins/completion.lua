local function is_cmdline()
  local mode = vim.fn.mode()
  return mode == ":" or mode == "/" or mode == "?" or mode == "@"
end

return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      --"giuxtaposition/blink-cmp-copilot",
    },
    version = "*",
    opts = {
      enabled = function()
        return not is_cmdline()
          and not vim.tbl_contains({}, vim.bo.filetype)
          and vim.bo.buftype ~= "prompt"
          and vim.bo.buftype ~= "cmdline"
          and vim.b.completion ~= false
      end,
      completion = {
        list = {
          selection = function(_)
            return "auto_insert"
          end,
        },
        trigger = {
          show_on_insert_on_trigger_character = true,
          show_on_keyword = true,
          show_on_trigger_character = true,
          show_on_accept_on_trigger_character = true,
        },
        menu = {
          auto_show = function(_)
            return true
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
        -- use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
      },
      sources = {
        cmdline = {},
        default = {
          "lsp",
          "path",
          "luasnip",
          "buffer",
          -- "copilot",
        },
        providers = {
          lsp = {
            name = "LSP",
            score_offset = 1000,
            module = "blink.cmp.sources.lsp",
          },
          -- copilot = {
          --   name = "copilot",
          --   module = "blink-cmp-copilot",
          --   score_offset = 2000,
          --   async = true,
          --   enabled = false,
          -- },
        },
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
