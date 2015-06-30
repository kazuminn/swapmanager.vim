
let s:save_cpo = &cpo
set cpo&vim


noremap :tabprevious<ENTER> :call s:delete_file()

function! s:delete_file(file_name)
  !rm file_name
endfunction!


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
  
  let user_option = &guioptions
  set guioptions+=v

  for e in file
      let choice = confirm("Are you sure you want to erase B swapfile?", "&y:yes\n&n:no")
      if choice == 0
         :echo "user cancel daialog."
      elseif choice == 1
         :echo "user select 'A answer'."
      elseif choice == 2
         :echo "user select 'B answer'."
      else
         :echo "ERROR"
      endif
      let &guioptions = user_option
  endfor
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
