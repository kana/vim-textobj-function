" textobj-function - Text objects for functions
" Copyright (C) 2007-2008 kana <http://whileimautomaton.net/>
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"{{{1

if exists('g:loaded_TOFunc')
  finish
endif




" KEY MAPPINGS  "{{{1

onoremap <silent> <Plug>TOFunc_A  :<C-u>call <SID>TOFunc_A('o')<Return>
vnoremap <silent> <Plug>TOFunc_A  :<C-u>call <SID>TOFunc_A('v')<Return>
onoremap <silent> <Plug>TOFunc_I  :<C-u>call <SID>TOFunc_I('o')<Return>
vnoremap <silent> <Plug>TOFunc_I  :<C-u>call <SID>TOFunc_I('v')<Return>


function! s:SafeMap(maptype, lhs, rhs)
  if !hasmapto(a:rhs, a:maptype[0])
    execute 'silent!' a:maptype '<unique>' a:lhs a:rhs
  endif
endfunction
call s:SafeMap('omap', 'af', '<Plug>TOFunc_A')
call s:SafeMap('vmap', 'af', '<Plug>TOFunc_A')
call s:SafeMap('omap', 'if', '<Plug>TOFunc_I')
call s:SafeMap('vmap', 'if', '<Plug>TOFunc_I')
delfunction s:SafeMap




" FUNCTIONS  "{{{1

let g:TOFunc = {}


function! s:TOFunc_A(mode)
  return s:SelectOrNop('GetRangeA', a:mode)
endfunction

function! s:TOFunc_I(mode)
  return s:SelectOrNop('GetRangeI', a:mode)
endfunction


" Abbreviations: B for the beginning position, E for the end position.
function! s:SelectOrNop(funcname, mode)
  if !exists('g:TOFunc[&filetype]')
    throw "Text object ``function'' is not available for this buffer."
  endif

  let prevpos = getpos('.')
  let range = g:TOFunc[&filetype][a:funcname]()
  if type(range) == type([])  " is there some code?
    let [func_b, func_e] = range
    call setpos('.', func_e)
    execute 'normal!' (a:mode == 'v' ? visualmode() : 'v')
    call setpos('.', func_b)
  else  " is there no code?
    if a:mode == 'o'  " operator-pending mode?
      call setpos('.', prevpos)
    else  " visual mode?
      normal! gv
    endif
  endif
endfunction




" ETC  "{{{1

let g:loaded_TOFunc = 1




" __END__  "{{{1
" vim: foldmethod=marker
