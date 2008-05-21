" TOFunc settings for Vim script
" Author: kana <http://whileimautomaton.net/>
" License: MIT license (see <http://www.opensource.org/licenses/mit-license>)

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
