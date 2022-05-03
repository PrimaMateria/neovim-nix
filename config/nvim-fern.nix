# vim: ft=vim
''
"-------------------------------------------------- 
" Fern
"-------------------------------------------------- 
nnoremap <C-n> :Fern . -drawer -toggle<CR>
function! s:init_fern() abort
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END
''
