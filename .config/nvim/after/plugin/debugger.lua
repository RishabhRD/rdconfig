require("dapui").setup {
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  layouts = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 },
      { id = "watches", size = 00.25 },
    },
    size = 70,
    position = "left", -- Can be "left", "right", "top", "bottom"
    {
      elements = { "repl" },
      size = 10,
      position = "bottom", -- Can be "left", "right", "top", "bottom"
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
}
require("telescope").load_extension "dap"
require("nvim-dap-virtual-text").setup()
local dap = require "dap"
local dapui = require "dapui"

dap.listeners.after.event_initialized["me"] = function()
  dapui.open()
end

dap.adapters.lldb = {
  type = "executable",
  command = "/usr/bin/lldb-vscode", -- adjust as needed
  name = "lldb",
}

local file_to_launch = nil
local args = nil

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return file_to_launch
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = function()
      return args
    end,
    runInTerminal = false,
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

local function set_file_to_launch()
  vim.ui.input({ prompt = "Executable path" }, function(input)
    input = input or file_to_launch
    file_to_launch = input
  end)
end

local function set_args_to_launch()
  vim.ui.input({ prompt = "Arguments" }, function(input)
    if input ~= nil then
      args = {}
      for k, _ in input:gmatch "%S+" do
        table.insert(args, k)
      end
    end
  end)
end

local function input_conditional_breakpoint()
  vim.ui.input({ prompt = "Breakpoint Condition" }, function(input)
    if input ~= nil then
      dap.set_breakpoint(input)
    end
  end)
end

local nnoremap = function(lhs, rhs, opts)
  vim.keymap.set("n", lhs, rhs, opts)
end

local vnoremap = function(lhs, rhs, opts)
  vim.keymap.set("v", lhs, rhs, opts)
end

local function pause_tid()
  dap.pause(vim.fn.input "Enter thread id: ")
end

local function eval_expression()
  vim.ui.input({ prompt = "Eval" }, function(input)
    if input ~= nil then
      dapui.eval(input)
    end
  end)
end

local function toggle_ui()
  dapui.toggle()
  vim.cmd [[DapVirtualTextForceRefresh]]
end

local function close_debugger()
  dapui.close()
  dap.disconnect()
  dap.close()
  vim.cmd [[DapVirtualTextForceRefresh]]
end

nnoremap("<leader>df", set_file_to_launch)
nnoremap("<leader>da", set_args_to_launch)
nnoremap("<leader>dc", dap.continue)
nnoremap("<leader>dl", dap.run_last)
nnoremap("<leader>dq", close_debugger)
nnoremap("<leader>db", dap.toggle_breakpoint)
nnoremap("<leader>dB", input_conditional_breakpoint)
nnoremap("<leader>dO", require("telescope").extensions.dap.list_breakpoints)
nnoremap("<leader>dC", dap.clear_breakpoints)
nnoremap("<leader>dn", dap.step_over)
nnoremap("<leader>ds", dap.step_into)
nnoremap("<leader>do", dap.step_out)
nnoremap("<leader>dp", pause_tid)
nnoremap("<leader>dK", dap.up)
nnoremap("<leader>dJ", dap.down)
nnoremap("<leader>dd", dap.run_to_cursor)
nnoremap("<leader>dr", dap.repl.toggle)
nnoremap("<leader>dt", [[<cmd>Telescope dap<CR>]])
nnoremap("<leader>de", eval_expression)
nnoremap("<leader>dk", dapui.eval)
vnoremap("<leader>dk", dapui.eval)
nnoremap("<leader>dui", toggle_ui)
