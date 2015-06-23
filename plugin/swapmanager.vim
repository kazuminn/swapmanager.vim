"swapfile manager
"Version  :1.0
"Author   :kazuminn
"License  :VIM LICENSE

if exists('g:loaded_swapmanager')
        finish
endif
let g:loaded_swapmanager = 1 


let s:save_cpo = &cpo
set cpo&vim

command! NoSwapfile :call s:noswap()
command! FindSwp :call s:FindSwp()

function! s:noswap()
        set noswapfile
endfunction

function! s:ChangeSwapDirectory(dir)
        set directory=(dir)
endfunction

function! s:FindSwp()
        call system("find . -name '.*.swp'")
        call system("find . -name '.swp'")
endfunction

function! s:FindSwo()
        call system("find . -name '.*.swo'")
        call system("find . -name '.swo'")
endfunction

function! s:FindSwn()
        call system("find . -name '.*.swn'")
        call system("find . -name '.swn'")
endfunction

function! s:FindAllSwap()
        call system("find . -name '.*.sw*'")
        call system("find . -name '.sw*'")
endfunction!

let &cpo = s:save_cpo
unlet s:save_cpo

