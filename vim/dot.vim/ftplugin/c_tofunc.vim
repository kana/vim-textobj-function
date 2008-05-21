" TOFunc settings for C
" Author: kana <http://whileimautomaton.net/>
" License: MIT license (see <http://www.opensource.org/licenses/mit-license>)
"
" BUGS: C functions must be written in the following style:
"
"           return-type
"           function-name(arg1, arg2, ..., argN)
"           {
"             ...
"           }
"
"       * return-type must be written in one line.
"
"       * function-name must be followed by ``(''.
"
"       * argument list may be written in one or more lines,
"         but the last line must end with ``)''.
"
" BUGS: If the cursor is between two functions,
"       the next function will be selected.

if exists('g:TOFunc.c')
  finish
endif




let g:TOFunc.c = {}


function! g:TOFunc.c.GetRangeA()
  if line('.') != '}'
    normal ][
  endif
  let e = getpos('.')
  normal [[
  normal! k$%0k
  let b = getpos('.')

  if 1 < e[1] - b[1]  " is ther some code?
    return [b, e]
  else
    return 0
  endif
endfunction


function! g:TOFunc.c.GetRangeI()
  if line('.') != '}'
    normal ][
  endif
  let e = getpos('.')
  normal [[
  let b = getpos('.')

  if 1 < e[1] - b[1]  " is ther some code?
    call setpos('.', b)
    normal! j0
    let b = getpos('.')
    call setpos('.', e)
    normal! k$
    let e = getpos('.')
    return [b, e]
  else
    return 0
  endif
endfunction

" __END__
