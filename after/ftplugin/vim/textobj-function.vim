" Vim additional ftplugin: vim/textobj-function
" Copyright (C) 2007-2009 kana <http://whileimautomaton.net/>
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

if exists('g:TOFunc.vim')
  finish
endif




let g:TOFunc.vim = {}
let s:BEGINNING_PATTERN = '^\s*fu\%[nction]\>'
let s:END_PATTERN = '^\s*endf\%[unction]\>'


function! g:TOFunc.vim.GetRangeA()
  if line('.') !~# s:END_PATTERN
    call searchpair(s:BEGINNING_PATTERN, '', s:END_PATTERN, 'W')
  endif
  normal! $
  let e = getpos('.')
  normal! 0
  call searchpair(s:BEGINNING_PATTERN, '', s:END_PATTERN, 'bW')
  let b = getpos('.')

  if b != e
    return [b, e]
  else
    return 0
  endif
endfunction


function! g:TOFunc.vim.GetRangeI()
  let range = g:TOFunc.vim.GetRangeA()
  if type(range) == type(0)
    return 0
  endif

  let [b, e] = range
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
