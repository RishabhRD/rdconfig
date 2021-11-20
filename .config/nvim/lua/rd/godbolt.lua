require("godbolt").setup {
  c = { compiler = "cg112", options = nil },
  cpp = { compiler = "clang1300", options = nil },
  rust = { compiler = "r1560", options = nil },
  -- any_additional_filetype = { compiler = ..., options = ... }
}
