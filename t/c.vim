filetype plugin on
runtime! plugin/textobj/function.vim

function! s:paste_c_code()
  read t/fixtures/sample.c
endfunction

describe '<Plug>(textobj-function-a)'
  before
    new
    setfiletype c
    call s:paste_c_code()
  end

  after
    close!
  end

  it 'selects the next function if there is no function under the cursor'
    normal! 1G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 3
    Expect line("'>") == 9
    Expect visualmode() ==# 'V'
  end

  it 'selects the function under the cursor'
    " At the first line.
    normal! 3G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 3
    Expect line("'>") == 9
    Expect visualmode() ==# 'V'

    " At a middle line.
    normal! 7G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 3
    Expect line("'>") == 9
    Expect visualmode() ==# 'V'

    " At the last line.
    normal! 9G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 3
    Expect line("'>") == 9
    Expect visualmode() ==# 'V'
  end

  it 'does not recognize a function if it is deeply indented'
    normal! 17G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 23
    Expect line("'>") == 29
    Expect visualmode() ==# 'V'
  end

  it 'recognizes functinos with alternative brace style'
    " With a one-line prototype
    normal! 34G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 31
    Expect line("'>") == 36
    Expect visualmode() ==# 'V'

    " With a more complex prototype
    normal! 44G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 38
    Expect line("'>") == 46
    Expect visualmode() ==# 'V'
  end
end

describe '<Plug>(textobj-function-i)'
  before
    new
    setfiletype c
    call s:paste_c_code()
  end

  after
    close!
  end

  it 'selects the content of the next function if the cursor is not on one'
    normal! 1G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 6
    Expect line("'>") == 8
    Expect visualmode() ==# 'V'
  end

  it 'selects the content of the function under the cursor'
    " At the first line.
    normal! 3G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 6
    Expect line("'>") == 8
    Expect visualmode() ==# 'V'

    " At a middle line.
    normal! 7G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 6
    Expect line("'>") == 8
    Expect visualmode() ==# 'V'

    " At the last line.
    normal! 9G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 6
    Expect line("'>") == 8
    Expect visualmode() ==# 'V'
  end

  it 'does not recognize a function if it is deeply indented'
    normal! 17G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 26
    Expect line("'>") == 28
    Expect visualmode() ==# 'V'
  end

  it 'recognizes functinos with alternative brace style'
    " With a one-line prototype
    normal! 34G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 33
    Expect line("'>") == 35
    Expect visualmode() ==# 'V'

    " With a more complex prototype
    normal! 44G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 43
    Expect line("'>") == 45
    Expect visualmode() ==# 'V'
  end
end
