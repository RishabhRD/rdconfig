local function get_debug_config()
  return {}
end

local explicit_debugger_path = {}

local function setup_debuggers()
  for k, f in pairs(get_debug_config()) do
    local path = explicit_debugger_path[k] or vim.fn.exepath(k)
    if path then
      f(path)
    end
  end
end

return {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = {
    "leoluz/nvim-dap-go",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
  },
  config = function()
    local dap = require "dap"
    local ui = require "dapui"

    local ui_config = {
      icons = { expanded = "🞃", collapsed = "🞂", current_frame = "→" },
      controls = {
        icons = {
          pause = "⏸",
          play = "⯈",
          step_into = "↴",
          step_over = "↷",
          step_out = "↑",
          step_back = "↶",
          run_last = "🗘",
          terminate = "🕱",
          disconnect = "⏻",
        },
      },
      layouts = {
        {
          elements = {
            {
              id = "scopes",
              size = 0.25,
            },
            {
              id = "breakpoints",
              size = 0.25,
            },
            {
              id = "stacks",
              size = 0.25,
            },
            {
              id = "watches",
              size = 0.25,
            },
          },
          position = "left",
          size = 80,
        },
        {
          elements = {
            {
              id = "repl",
              size = 0.5,
            },
            {
              id = "console",
              size = 0.5,
            },
          },
          position = "bottom",
          size = 10,
        },
      },
    }

    require("dapui").setup(ui_config)
    require("dap-go").setup()
    require("mason").setup {}
    require("nvim-dap-virtual-text").setup()

    require("mason-nvim-dap").setup {
      automatic_setup = true,
      handlers = {
        function(config)
          require("mason-nvim-dap").default_setup(config)
          setup_debuggers()
        end,
      },
    }

    vim.cmd [[command! DapToggle lua require('dap-ui').toggle()]]
    vim.keymap.set("n", "<space>db", dap.toggle_breakpoint)
    vim.keymap.set("n", "<space>dc", dap.run_to_cursor)
    vim.keymap.set("n", "<space>dx", function()
      ui.close()
      dap.terminate()
      dap.disconnect { terminateDebuggee = true }
      dap.close()
      vim.cmd [[DapVirtualTextForceRefresh]]
    end)
    vim.keymap.set("n", "<space>dt", ui.toggle)

    -- Eval var under cursor
    vim.keymap.set("n", "<space>?", function()
      require("dapui").eval(nil, { enter = true })
    end)

    vim.keymap.set("n", "<F1>", dap.continue)
    vim.keymap.set("n", "<F2>", dap.step_into)
    vim.keymap.set("n", "<F3>", dap.step_over)
    vim.keymap.set("n", "<F4>", dap.step_out)
    vim.keymap.set("n", "<F5>", dap.step_back)
    vim.keymap.set("n", "<F13>", dap.restart)

    dap.listeners.before.attach.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      ui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      ui.close()
    end
  end,
}
