syntax on
filetype plugin indent on

let mapleader = " "
inoremap <C-j><C-j> <C-\><C-n>
tnoremap <C-j><C-j> <C-\><C-n>
nnoremap <leader><BS> :b#<CR>
" copy last message to clipboard
nnoremap <leader>m :let @+=trim(execute('1messages')) \| echo 'copied' <cr>

"-------------------------------------------------- 
" \
"-------------------------------------------------- 
nnoremap \\ :w<cr>

"-------------------------------------------------- 
" Autocommands
"-------------------------------------------------- 
augroup primamateria-usability
  autocmd!
  " Don't add comment sign on new line automatically
  autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
  autocmd FileType help wincmd L

  " Issue with resetting eol
  autocmd BufEnter * set eol
  autocmd BufEnter * set textwidth=80
  autocmd BufEnter * set formatexpr=
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

augroup theme
   autocmd!
   autocmd ColorScheme * highlight SignColumn guibg=#1d2021
   autocmd ColorScheme * highlight ColorColumn guibg=#222222
   autocmd ColorScheme * highlight CursorColumn guibg=#151515
   autocmd ColorScheme * highlight CursorLine guibg=#151515
   autocmd ColorScheme * highlight LineNr guifg=#fabd2f
   autocmd ColorScheme * highlight LineNrAbove guifg=#86817e
   autocmd ColorScheme * highlight LineNrBelow guifg=#86817e
   autocmd ColorScheme * highlight Pmenu guibg=#1d2021 guifg=#ebdbb2
   autocmd ColorScheme * highlight NormalFloat guifg=#ebdbb2
   autocmd ColorScheme * highlight Comment guifg=#bbbbbb
augroup END

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
