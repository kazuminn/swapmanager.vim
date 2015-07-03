let s:save_cpo = &cpo
set cpo&vim


nmap W :call Delete_file()



function! Os()
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


function! Path()
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





function! Delete_file() 
    let s:file_name   = getline('.')   
    delete                              
    call delete(s:file_name)           
endfunction



function! All_delete_file(buffer_name)
    s:file_name_list = readfile(a:buffer_name)
    for name in s:file_name_list
        deletes(name)
    endfor
    q!
endfunction



function! Count_Swap_File()  "スワップファイルの数を求める。
    call system("find . -name '*.sw*' | wc -l")     
endfunction



function! s:noswap()
    set noswapfile
endfunction


function! s:ChangeSwapDirectory(dir)
    set directory=(dir)
endfunction


function! s:FindSwp()
    redi > new
    call system("find . -name '.*.swp'")
    call system("find . -name '.swp'")
    redi END
endfunction


function! FindSwo()
    new | read !find ~/ -name '.*.swo'
    redraw!
    w swofile.txt
    call All_delete_file("swofile.txt")
endfunction


function! s:FindSwn()
    call system("find . -name '.*.swn'")
    call system("find . -name '.swn'")
endfunction


function! s:FindAllSwap()
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

function! Add_Noswapfile() "swapfileを作成したくないファイルを管理する関数
    call noswap()
    let s:path = Path()
    if !empty(glob("~/.vimrc")) "もしあれば
        let lines = [ expand("%:p") ]
        call writefile(lines, s:path)
    else
        let s:number = %s/^//n
        let s:line_number = matchstr(s:number,'^13')
        writefile(s:line_number,s:path)
    endif
endfunction


function! No_File_Swapfile() "スワップファイルがあるのにファイルがないswapfileを削除

endfunction

function! No_File_Swapfile_Restore() "スワップファイルがあるのにファイルがないswapfileから復元

endfunction



let &cpo = s:save_cpo
unlet s:save_cpo
