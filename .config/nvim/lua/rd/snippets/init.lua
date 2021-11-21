vim.cmd [[
  imap <silent><expr> <c-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-k>'
  inoremap <silent> <c-k> <cmd>lua require('luasnip').jump(-1)<CR>

  imap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>'

  snoremap <silent> <c-j> <cmd>lua require('luasnip').jump(1)<CR>
  snoremap <silent> <c-k> <cmd>lua require('luasnip').jump(-1)<CR>
]]

require "rd.snippets.all"
require "rd.snippets.cpp"
