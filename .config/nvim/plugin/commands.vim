command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command! -nargs=* Format lua require'rd.formatter'.format <q-args>
command! DiagHide lua vim.diagnostic.hide()
command! DiagShow lua vim.diagnostic.show()
