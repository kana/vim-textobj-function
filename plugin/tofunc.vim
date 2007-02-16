" tofunc - Text object for a function.
" Author: kana <http://nicht.s8.xrea.com/>
" License: MIT license (see <http://www.opensource.org/licenses/mit-license>)
" $Id$
" MANUAL  "{{{1
" =============
"
" To enable text object for a function,
" the buffer-local variable b:TOFunc must be defined.
" b:TOFunc is a dictionary with the following entries.
"
" b:TOFunc.AfterP
"     Funcref to a function that
"     takes a string of the current line
"     and returns true if the given line is the next line of the body of a
"     function.
"
" b:TOFunc.MoveBefore
"     Funcref to a function that
"     moves the cursor to the previous line of the body of a function.
"
" b:TOFunc.MoveAfter
"     Funcref to a function that
"     moves the cursor to the next line of the body of a function.
"
" b:TOFunc.EndP
"     Like AfterP of TextObject_Function_Inner,
"     but returns true if the given line is the end line of a function.
"
" b:TOFunc.MoveBeginning
"     Like MoveBefore of TextObject_Function_Inner,
"     but move the cursor to the beginning line of a function.
"
" b:TOFunc.MoveEnd
"     Like MoveAfter of TextObject_Function_Inner,
"     but move the cursor to the end line of a function.
"
" BUGS: Visual mode will be linewise after these text objects.
"
" BUGS: In visual mode, the previous selection will be forgotten
"       and will be replaced by new selection with this text object.

if exists('g:loaded_TOFunc')
  finish
endif




" KEY MAPPINGS  "{{{1

noremap <script> <Plug>TOFunc_Inner  <SID>TOFunc_Inner
noremap <script> <Plug>TOFunc_All  <SID>TOFunc_All

noremap <silent> <SID>TOFunc_Inner  :<C-u>call <SID>TOFunc_Inner()<Return>
noremap <silent> <SID>TOFunc_All  :<C-u>call <SID>TOFunc_All()<Return>

if !hasmapto('<Plug>TOFunc_Inner')
  silent! vmap <unique> if  <Plug>TOFunc_Inner
  silent! omap <unique> if  <Plug>TOFunc_Inner
endif
if !hasmapto('<Plug>TOFunc_All')
  silent! vmap <unique> af  <Plug>TOFunc_All
  silent! omap <unique> af  <Plug>TOFunc_All
endif




" FUNCTIONS  "{{{1

function! s:TOFunc_Inner()
  if !exists('b:TOFunc')
    throw "Text object ``inner function'' is not available for this buffer."
  endif

  let current_position = getpos('.')

  if !b:TOFunc.AfterP(getline('.'))
    call b:TOFunc.MoveAfter()
  endif
  let e = line('.')
  call b:TOFunc.MoveBefore()
  let b = line('.')

  if 1 < e - b  " is there some code?
    execute 'normal!' (b+1).'G'
    normal! V
    execute 'normal!' (e-1).'G'
  else  " is there no code?
    if mode() == 'n'  " operator-pending mode?
      call setpos('.', current_position)
    else  " visual mode?
      normal! gv
    endif
  endif
endfunction


function! s:TOFunc_All()
  if !exists('b:TOFunc')
    throw "Text object ``all function'' is not available for this buffer."
  endif

  if !b:TOFunc.EndP(getline('.'))
    call b:TOFunc.MoveEnd()
  endif
  let e = line('.')
  call b:TOFunc.MoveBeginning()
  let b = line('.')

  execute 'normal' b.'G'
  normal V
  execute 'normal' e.'G'
endfunction




" ETC  "{{{1

let g:loaded_TOFunc = 1

" __END__
" vim: foldmethod=marker
