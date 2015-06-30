set cpo&vim


nmap W :call Delete_file()

function! Delete_file()
  let s:file_name   = getline('.')   
  delete                              
  call delete(s:file_name)           
endfunction

function! All_delete_file(buffer_name)
  s:file_name_list = readfile(a:buffer_name)
  for name in 
    deletes(s:file_name_list)
  endfor
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


function! Hoge()
  echo "Plase wait. now louding swapfile..."
  new | read !find ~/ -name '.*.sw*'

  redraw!
"  silent rm swapfile.txt
  w swapfile.txt
  
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
