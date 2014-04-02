filetype plugin on
runtime! plugin/textobj/function.vim

function! s:paste_java_code()
  read t/fixtures/sample.java
endfunction

describe '<Plug>(textobj-function-a)'
  before
    new
    setfiletype java
    call s:paste_java_code()
  end

  after
    close!
  end

  it 'selects the next method if there is no method under the cursor'
    normal! 2G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 4
    Expect line("'>") == 8
    Expect visualmode() ==# 'V'
  end

  it 'selects the method under the cursor'
    " At the first line.
    normal! 4G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 4
    Expect line("'>") == 8
    Expect visualmode() ==# 'V'

    " At a middle line.
    normal! 6G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 4
    Expect line("'>") == 8
    Expect visualmode() ==# 'V'

    " At the last line.
    normal! 8G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 4
    Expect line("'>") == 8
    Expect visualmode() ==# 'V'
  end

  it 'ignores non-method blocks'
    normal! 14G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 10
    Expect line("'>") == 18
    Expect visualmode() ==# 'V'
  end

  it 'recognizes methods with alternative brace styles'
    " With a one-line prototype
    normal! 23G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 20
    Expect line("'>") == 25
    Expect visualmode() ==# 'V'

    " With a more complex prototype
    normal! 30G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 27
    Expect line("'>") == 32
    Expect visualmode() ==# 'V'

    normal! 38G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 34
    Expect line("'>") == 40
    Expect visualmode() ==# 'V'

    normal! 47G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 42
    Expect line("'>") == 49
    Expect visualmode() ==# 'V'
  end
end

describe '<Plug>(textobj-function-i)'
  before
    new
    setfiletype java
    call s:paste_java_code()
  end

  after
    close!
  end

  it 'selects the next method if there is no method under the cursor'
    normal! 2G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 5
    Expect line("'>") == 7
    Expect visualmode() ==# 'V'
  end

  it 'selects the method under the cursor'
    " At the first line.
    normal! 4G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 5
    Expect line("'>") == 7
    Expect visualmode() ==# 'V'

    " At a middle line.
    normal! 6G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 5
    Expect line("'>") == 7
    Expect visualmode() ==# 'V'

    " At the last line.
    normal! 8G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 5
    Expect line("'>") == 7
    Expect visualmode() ==# 'V'
  end

  it 'ignores non-method blocks'
    normal! 14G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 11
    Expect line("'>") == 17
    Expect visualmode() ==# 'V'
  end

  it 'recognizes methods with alternative brace styles'
    " With a one-line prototype
    normal! 23G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 22
    Expect line("'>") == 24
    Expect visualmode() ==# 'V'

    " With a more complex prototype
    normal! 30G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 29
    Expect line("'>") == 31
    Expect visualmode() ==# 'V'

    normal! 38G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 37
    Expect line("'>") == 39
    Expect visualmode() ==# 'V'

    normal! 47G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 46
    Expect line("'>") == 48
    Expect visualmode() ==# 'V'
  end
end
