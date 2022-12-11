vim.cmd [[
imap <silent><expr> <C-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
" -1 for jumping backwards.
inoremap <silent> <C-k> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <C-j> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <C-k> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
]]

require "rd.snippets.all"
require "rd.snippets.cpp"
require "rd.snippets.haskell"
