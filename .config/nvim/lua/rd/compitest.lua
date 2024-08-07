require("competitest").setup {
  local_config_file_name = ".competitest.lua",

  floating_border = "rounded",
  floating_border_highlight = "FloatBorder",
  picker_ui = {
    width = 0.2,
    height = 0.3,
    mappings = {
      focus_next = { "j", "<down>", "<Tab>" },
      focus_prev = { "k", "<up>", "<S-Tab>" },
      close = { "<Esc>", "q", "Q" },
      submit = { "<CR>" },
    },
  },
  editor_ui = {
    popup_width = 0.3,
    popup_height = 0.6,
    show_nu = false,
    show_rnu = false,
    normal_mode_mappings = {
      switch_window = { "<C-w>h", "<C-w>l", "<C-w><C-l>", "<C-w><C-h>" },
      save_and_close = {},
      cancel = {},
    },
    insert_mode_mappings = {
      switch_window = {},
      save_and_close = {},
      cancel = {},
    },
  },
  runner_ui = {
    interface = "split",
    selector_show_nu = false,
    selector_show_rnu = false,
    show_nu = false,
    show_rnu = false,
    mappings = {
      run_again = "R",
      run_all_again = "<C-r>",
      kill = "K",
      kill_all = "<C-k>",
      view_input = { "i", "I" },
      view_output = { "a", "A" },
      view_stdout = { "o", "O" },
      view_stderr = { "e", "E" },
      toggle_diff = { "d", "D" },
      close = {},
    },
    viewer = {
      width = 0.5,
      height = 0.5,
      show_nu = false,
      show_rnu = false,
      close_mappings = {},
    },
  },
  popup_ui = {
    total_width = 0.8,
    total_height = 0.8,
    layout = {
      { 4, "tc" },
      { 5, { { 1, "so" }, { 1, "si" } } },
      { 5, { { 1, "eo" }, { 1, "se" } } },
    },
  },
  split_ui = {
    position = "right",
    relative_to_editor = true,
    total_width = 0.4,
    vertical_layout = {
      { 1, "tc" },
      { 1, { { 1, "so" }, { 1, "eo" } } },
      { 1, { { 1, "si" }, { 1, "se" } } },
    },
    total_height = 0.4,
    horizontal_layout = {
      { 2, "tc" },
      { 3, { { 1, "so" }, { 1, "si" } } },
      { 3, { { 1, "eo" }, { 1, "se" } } },
    },
  },

  save_current_file = false,
  save_all_files = false,
  compile_directory = ".",
  compile_command = {
    c = { exec = "gcc", args = { "-Wall", "$(FNAME)", "-o", "bin/$(FNOEXT)" } },
    cpp = { exec = "g++", args = { "-std=c++20", "-Wall", "$(FNAME)", "-o", "bin/$(FNOEXT)" } },
    rust = { exec = "rustc", args = { "$(FNAME)" } },
    java = { exec = "javac", args = { "$(FNAME)" } },
    haskell = { exec = "ghc", args = { "$(FNAME)", "-o", "bin/$(FNOEXT)", "-odir", "bin", "-hidir", "bin" } },
  },
  running_directory = ".",
  run_command = {
    c = { exec = "bin/$(FNOEXT)" },
    cpp = { exec = "bin/$(FNOEXT)" },
    rust = { exec = "./$(FNOEXT)" },
    python = { exec = "python", args = { "$(FNAME)" } },
    java = { exec = "java", args = { "$(FNOEXT)" } },
    haskell = { exec = "bin/$(FNOEXT)" },
  },
  multiple_testing = -1,
  maximum_time = 5000,
  output_compare_method = "squish",
  view_output_diff = false,

  testcases_directory = ".",
  testcases_use_single_file = false,
  testcases_auto_detect_storage = true,
  testcases_single_file_format = "$(FNOEXT).testcases",
  testcases_input_file_format = "$(FNOEXT)_input$(TCNUM).txt",
  testcases_output_file_format = "$(FNOEXT)_output$(TCNUM).txt",

  companion_port = 27121,
  receive_print_message = true,
}

vim.keymap.set("n", "<leader>cfr", ":Competitest run<CR>")
vim.keymap.set("n", "<leader>cfl", ":Competitest receive testcases<CR>")
