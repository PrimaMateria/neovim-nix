# vim: ft=vim
ultisnipsSnippets: ''
  "-------------------------------------------------- 
  " UltiSnips
  "-------------------------------------------------- 
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<c-j>"
  let g:UltiSnipsJumpBackwardTrigger="<c-k>"
  let g:UltiSnipsEditSplit="vertical"
  let g:UltiSnipsSnippetDirectories=["${ultisnipsSnippets}"]

  augroup ultisnips
    au!
    autocmd FileType javascript,javascriptreact,typescript,typescriptreact
      \ UltiSnipsAddFiletypes javascript.javascriptreact.typescript.typescriptreact
  augroup END
''
