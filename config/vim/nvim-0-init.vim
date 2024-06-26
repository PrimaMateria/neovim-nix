syntax on
filetype plugin indent on

let mapleader = " "
" inoremap <C-j><C-j> <C-\><C-n>init
" tnoremap <C-j><C-j> <C-\><C-n>
tnoremap <C-]><C-[> <C-\><C-n>
inoremap <C-]><C-[> <C-\><C-n>

" nnoremap <leader><BS> :b#<CR>
" copy last message to clipboard
nnoremap <leader>m :let @+=trim(execute('1messages')) \| echo 'copied' <cr>

" Remap Ctrl+q to start recording a macro
nnoremap <C-q> q
" Disable the original q keybinding
nnoremap q <Nop>

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
  autocmd BufEnter * set textwidth=80
  autocmd BufEnter * set formatexpr=
augroup END

augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END

if system('uname -r') =~ "microsoft"
  let g:clipboard = {
    \   'name': 'WslClipboard',
    \   'copy': {
    \      '+': 'clip.exe',
    \      '*': 'clip.exe',
    \    },
    \   'paste': {
    \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    \   },
    \   'cache_enabled': 0,
    \ }
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

" Turn on spell for chosen filetypes
augroup spellon
  autocmd!
  autocmd FileType typescriptreact setlocal spell
  autocmd FileType typescript setlocal spell
augroup END


