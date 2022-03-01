require("godbolt").setup {
  c = { compiler = "cg112", options = {} },
  cpp = { compiler = "clang1300", options = {} },
  rust = { compiler = "r1560", options = {} },
  -- any_additional_filetype = { compiler = ..., options = ... }
}
