

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


