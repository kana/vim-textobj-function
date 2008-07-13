" TOFunc settings for C
" Author: kana <http://whileimautomaton.net/>
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
