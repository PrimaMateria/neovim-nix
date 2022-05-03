# vim: ft=vim
''
syntax on
filetype plugin indent on

let mapleader = " "
inoremap <C-j><C-j> <C-\><C-n>
tnoremap <C-j><C-j> <C-\><C-n>
nnoremap <leader><BS> :b#<CR>

"-------------------------------------------------- 
" Gruvbox community Color scheme
"-------------------------------------------------- 
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

"-------------------------------------------------- 
" \
"-------------------------------------------------- 
nnoremap \\ :w<cr>
nnoremap \s :so %<cr>
nnoremap \w :bw!<cr>
nnoremap \g :Goyo<cr>
nnoremap \i :PlugInstall<cr>
nnoremap \c :PlugClean<cr>
nnoremap \t :term<cr>
''
