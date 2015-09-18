"swapfile manager
"Version  :1.0
"Author   :kazuminn
"License  : MIT LICENSE

if exists('g:loaded_swapmanager')
        finish
endif
let g:loaded_swapmanager = 1 


let s:save_cpo = &cpo
set cpo&vim

command! NoSwapFile :call s:noswap()
command! FindSwp :call s:FindSwp()
command! FindSwo :call s:FindSwo()
command! FindSwn :call s:FindSwn()
command! FindAllSwap :call s:FindAllSwap()
command! Piyo :call Hoge() |

nnoremap <silent> <Plug>(swapmanager) :<c-u>FindAllSwap<CR>

if !hasmapto('<plug>(swapmanager)')
    silent! map <unique> <Leader>sw <Plug>(swapmanager)
endif

let &cpo = s:save_cpo
unlet s:save_cpo

