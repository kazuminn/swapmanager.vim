scriptencoding utf-8

function! s:SID()
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfun
let s:sid = s:SID()

let s:str = [
\'(ﾟДﾟ;)',
\'(  ﾟД)',
\'(    ﾟ)',
\'(     )',
\'(ﾟ;   )',
\'(Дﾟ; )']

function! s:progressbar_paint() dict
  let max_len = winwidth(self.winnr)-1
  let t_len = strlen(self.title)+1+1
  let c_len  = 2*strlen(self.max_value)+1+1+1
  let pb_len = max_len - t_len - c_len - 2 - 7
  let cur_pb_len = (pb_len*self.cur_value)/self.max_value

  let t_color = self.items.title.color
  let b_fcolor = self.items.bar.fillcolor
  let b_color = self.items.bar.color
  let c_color = self.items.counter.color
  let fc= strpart(self.items.bar.fillchar." ",0,1)

  let stl =  "%#".t_color."#%-( ".self.title." %)".
            \"%#".b_color."#|".
            \"%#".b_fcolor."#%-(".repeat(fc,cur_pb_len)."%)".
            \"%#".b_color."#".repeat(" ",pb_len-cur_pb_len).s:str[self.cur_value%len(s:str)]."|".
            \"%=%#".c_color."#%( ".repeat(" ",(strlen(self.max_value) - strlen(self.cur_value))).self.cur_value."/".self.max_value."  %)"
  set laststatus=2
  call setwinvar(self.winnr,"&stl",stl)
  redraw
endfun

let pb = vim#widgets#progressbar#NewSimpleProgressBar("Processing:", 100)
let pb['paint'] = function(printf('<SNR>%d_progressbar_paint', s:sid))

for i in range(0, 100)
  sleep 50ms
  call pb.incr()
endfor
call pb.restore()
