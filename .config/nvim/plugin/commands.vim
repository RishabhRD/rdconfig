command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command! -nargs=* Format lua require'rd.formatter'.format <q-args>
command! DiagHide lua vim.diagnostics.hide()
command! DiagHide lua vim.diagnostics.show()
command! OverlengthToggle call overlength#toggle()
