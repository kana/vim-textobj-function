" TOFunc - Text object for a function.
" Author: kana <http://nicht.s8.xrea.com/>
" License: MIT license (see <http://www.opensource.org/licenses/mit-license>)
" $Id$
" MANUAL  "{{{1
" =============
"
" TOFunc provides the following text objects:
"
"                                                       *v_af* *af*
" af                    ``a function'', select the all range of a function.
"
"                                                       *v_if* *if*
" if                    ``inner function'', select the body of a function,
"                       but other parts of a function are not included
"                       (e.g. its name, its arguments and so forth).
"
"
" TOFunc uses the following functions to get the appropriate range of a
" function for the current 'filetype':
"
" g:TOFunc[&filetye].GetRangeI()                        *GetRangeI()*
"                       Returns the range of ``inner function''.
"                       The return value is [b, e], where b is the beginning
"                       position and e is the end position of the range.
"                       The detail of both values are same as |getpos()|. If
"                       there is no appropriate function, this function must
"                       return 0.
"
"                       Moving the cursor is allowed, but it is restored
"                       afterwards.
"
" g:TOFunc[&filetye].GetRangeA()                        *GetRangeA()*
"                       Like |GetRangeI()|,
"                       but returns the range of ``a function''.

if exists('g:loaded_TOFunc')
  finish
endif




" KEY MAPPINGS  "{{{1

noremap <silent> <Plug>TOFunc_AO  :<C-u>call <SID>TOFunc_A('o')<Return>
noremap <silent> <Plug>TOFunc_AV  :<C-u>call <SID>TOFunc_A('v')<Return>
noremap <silent> <Plug>TOFunc_IO  :<C-u>call <SID>TOFunc_I('o')<Return>
noremap <silent> <Plug>TOFunc_IV  :<C-u>call <SID>TOFunc_I('v')<Return>


function! s:SafeMap(mode, lhs, rhs)
  if !hasmapto(a:rhs)
    execute 'silent!' a:mode '<unique>' a:lhs a:rhs
  endif
endfunction
call s:SafeMap('omap', 'af', '<Plug>TOFunc_AO')
call s:SafeMap('vmap', 'af', '<Plug>TOFunc_AV')
call s:SafeMap('omap', 'if', '<Plug>TOFunc_IO')
call s:SafeMap('vmap', 'if', '<Plug>TOFunc_IV')
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

" __END__
" vim: foldmethod=marker
