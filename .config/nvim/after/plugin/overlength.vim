if !get(g:, 'loaded_overlength')
    finish
endif

let overlength#highlight_to_end_of_line = v:false
let overlength#default_overlength = 80

" Disable highlighting in markdown.
call overlength#disable_filetypes([
      \ 'vimwiki',
      \ 'qf',
      \ 'term',
      \ 'html',
      \ 'startify',
      \ 'man',
      \ 'term',
      \ 'help',
      \ '',
      \ ])

call overlength#set_overlength('vim', 140)
call overlength#set_overlength('lua', 140)
call overlength#disable()

nnoremap <leader>to <cmd>OverlengthToggle<CR>
