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

augroup gruvboxColorScheme
   autocmd!
   autocmd ColorScheme * highlight CursorLine guibg=#222222
   autocmd ColorScheme * highlight CursorColumn guibg=#222222
augroup END

"-------------------------------------------------- 
" \
"-------------------------------------------------- 
nnoremap \\ :w<cr>
nnoremap \s :so %<cr>
nnoremap \w :bw!<cr>
nnoremap \g :Goyo<cr>
nnoremap \i :PlugInstall<cr>
nnoremap \c :PlugClean<cr>

"-------------------------------------------------- 
" Autocommands
"-------------------------------------------------- 
augroup primamateria-usability
  autocmd!
  " Don't add comment sign on new line automatically
  autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
  autocmd FileType help wincmd L
augroup END

augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END

if system('uname -r') =~ "Microsoft"
  augroup Yank
    autocmd!
    autocmd TextYankPost * :call system('/mnt/c/windows/system32/clip.exe ',@")
  augroup END
endif

"-------------------------------------------------- 
" Tabs
"-------------------------------------------------- 
nnoremap <A-j> :tabprevious<cr>
nnoremap <A-k> :tabnext<cr>
nnoremap <A-1> :tabnext1<cr>
nnoremap <A-2> :tabnext2<cr>
nnoremap <A-3> :tabnext3<cr>
nnoremap <A-4> :tabnext4<cr>
nnoremap <A-5> :tabnext5<cr>
nnoremap <A-6> :tabnext6<cr>
nnoremap <A-7> :tabnext7<cr>
nnoremap <A-8> :tabnext8<cr>
nnoremap <A-9> :tabnext9<cr>
''
