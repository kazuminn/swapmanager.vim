let s:save_cpo = &cpo
set cpo&vim


nmap W :call Delete_file()

augroup swap
  autocmd!
  autocmd vimEnter * :call Auto_Noswapfile() 
  autocmd BufReadPre * :call Auto_Noswapfile()  
augroup END 

"------------------------------------------------------------------------------------
"osの違いを埋める
function! Os() "osの判断
  if exists('g:swap_user_os')
    return g:shaberu_user_os
  else
    if has('win16') || has('win32') || has('win64')
      let g:swap_user_os = 'win'
    elseif has('win32unix')
      let g:swap_user_os = 'win'
    elseif (has('mac') || has('macunix') || has('gui_macvim') ||
          \ (!executable('xdg-open') &&
          \ system('uname') =~? '^darwin'))
      let g:swap_user_os = 'mac'
    elseif system('uname') =~? '^Linux'
      let g:swap_user_os = 'linux'
    elseif has('unix')
      let g:swap_user_os = 'unix'
    else
      let g:swap_user_os = 'unknown'
    endif
    return g:swap_user_os
  endif
endfunction


function! Path() "osによっての、カレントディレクトリ表現
  if exists('g:swapfile_user_define_say_command')
    return g:shaberu_user_define_say_command
  else
    let l:os = Os()
    if l:os == 'win'
      return '%UserProfile%' 
    elseif l:os == 'mac'
      return '~'
    elseif l:os == 'unix'
        return '~'
    elseif l:os == 'linux'
        return '~'
    endif
  endif
  return 0
endfunction





function! Delete_file()  "カーソル行のファイルを削除する関数
    let s:file_name   = getline('.')   
    delete                              
    call delete(s:file_name)           
endfunction



function! All_delete_file(buffer_name) "すべてのswapfileを削除する関数
    s:file_name_list = readfile(a:buffer_name)
    for name in s:file_name_list
        deletes(name)
    endfor
    q!
endfunction



function! Count_Swap_File()  "スワップファイルの数を求める関数
    call system("find . -name '*.sw*' | wc -l")     
endfunction



function! s:Noswap() "swapfileを作らないようにするset noswapfileのalias
    set noswapfile
endfunction


function! s:ChangeSwapDirectory(dir) "指定したディレクトリのswapfileをすべて削除
    set directory=(dir)
endfunction


function! s:FindSwp()  "swpを見つける関数
    redi > new
    call system("find . -name '.*.swp'")
    call system("find . -name '.swp'")
    redi END
endfunction


function! FindSwo() "swoを見つける関数
    new | read !find ~/ -name '.*.swo'
    redraw!
    w swofile.txt
    call All_delete_file("swofile.txt")
endfunction


function! s:FindSwn() "swnを見つける関数
    call system("find . -name '.*.swn'")
    call system("find . -name '.swn'")
endfunction


function! s:FindAllSwap() "すべてのswapfileを見つける関数
    call system("find . -name '.*.sw*'")
    call system("find . -name '.sw*'")
endfunction!


"test function
function! Hoge()
    echo "Plase wait. now louding swapfile..."
    new | read !find ~/ -name '.*.sw*'

    redraw!
    w swapfile.txt
endfunction




"----------------------------------------------------------------------------------
"swapfileを作りたくないファイルを管理する関数群


function! Add_Noswapfile() abort "(あるファイルにファイル名を追加
    call s:Noswap()
    call No_Readd()
    "let s:path = Path()
    let s:path = ".test"
    let s:file_name = expand("%:p")
    if !empty(glob(".test"))
        redir! >> .test 
            echo expand("%:p") 
        redir END
    else
        let s:lines = [ s:file_name ]
        call writefile(s:lines, s:path)
    endif
endfunction


function! No_Readd() "ファイル名がすでに追記されている場合は追加しない。
    for line in readfile(".test") 
        if 0  == match(line,expand("%:p"))
            reigaihassei
        endif
    endfor
endfunction


function! This_File_No_Swapfile() "カレントファイルがswapfileを作ったらダメなのか調べる関数
    for line in readfile(".test") 
        if 0  == match(line,expand("%:p"))
            echo "This file is no-create-swapfile"
        endif
    endfor
endfunction


function! Auto_Noswapfile() "カレントファイルがswapfileを作ったらダメだったら,set noswapfileする関数
    call This_File_No_Swapfile()
    call s:Noswap()
endfunction

"----------------------------------------------------------------------------------
"スワップファイルがあるのにファイルがないswapfileを削除
function! No_File_Swapfile() 
    find . -name '.*.swn'
endfunction

"-----------------------------------------------------------------------------------
""スワップファイルがあるのにファイルがないswapfileから復元
function! No_File_Swapfile_Restore() 

endfunction



let &cpo = s:save_cpo
unlet s:save_cpo
