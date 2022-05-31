# vim: ft=vim
''
"-------------------------------------------------- 
" Fern
"-------------------------------------------------- 
let g:fern#disable_drawer_auto_winfixwidth=1
nnoremap <silent> <Plug>(my-fern-toggle) :Fern . -drawer -reveal=% -width=60 -toggle<CR>
nmap <C-n> <Plug>(my-fern-toggle)<Plug>(fern-action-zoom:reset)

function! s:init_fern() abort
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END
''
