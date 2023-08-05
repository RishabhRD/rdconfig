nnoremap <silent> <A-L> :tabnext<CR>
nnoremap <silent> <A-H> :tabprevious<CR>
nnoremap <silent> <leader>r :set hlsearch!<CR>
nnoremap <silent> <leader>un :UndotreeToggle<CR>

vnoremap <silent> cp "+y
nnoremap <silent> cp "+y
nnoremap <silent> cpp "+yy
vnoremap <silent> zp "+p
vnoremap <silent> zP "+P
nnoremap <silent> zp "+p
nnoremap <silent> zP "+P
vnoremap <silent> <leader>p "_dP

tnoremap <silent> ,, <C-\><C-n>

" nnoremap <silent> <A-l> :vertical resize +3<CR>
" nnoremap <silent> <A-h> :vertical resize -3<CR>
" nnoremap <silent> <A-k> :resize +3<CR>
" nnoremap <silent> <A-j> :resize -3<CR>

nnoremap <silent> - :Ex<CR>
nnoremap <silent> <leader>sC :CheatWithoutComments<CR>
nnoremap <silent> <leader>sc :Cheat<CR>

vnoremap <silent> <C-r> "hy:%s/<C-r>h/

nnoremap <silent><expr> k (v:count >= 3 ? "m'" . v:count : "") . 'k'
nnoremap <silent><expr> j (v:count >= 3 ? "m'" . v:count : "") . 'j'

nnoremap <silent> <leader>tt :lua require'rd.colors'.toggle_transparency()<CR>

nnoremap <silent> <C-t> <C-t>:cclose<CR>:lclose<CR>

" save and execute
nnoremap <leader><leader>x :call rd#save_and_exec()<CR>


" Map execute this line
function! s:executor() abort
  if &ft == 'lua'
    call execute(printf(":lua %s", getline(".")))
  elseif &ft == 'vim'
    exe getline(".")
  else
    exe getline(".")
  endif
endfunction
nnoremap <leader>x :call <SID>executor()<CR>

" Easy normal mode command writing
nnoremap <leader><leader>n :normal!<space>
" Execute last command
nnoremap <leader><leader>c :<up>
" Remove whitespace
nnoremap <leader>sws :%s/\s\+$//<CR>

" Because I use <C-f> as tmux prefix
inoremap <C-x><C-x> <C-x><C-f>

nnoremap <leader>acr :lua require"rd.colors".my_default_config()<CR>
nnoremap <leader>aco :set colorcolumn=

nnoremap <leader>= :Neoformat<CR>
nnoremap <leader>cfr :CompetiTest run<CR>
nnoremap <leader>cfl :CompetiTest receive testcases<CR>
