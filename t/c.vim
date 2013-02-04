filetype plugin on
runtime! plugin/textobj/function.vim

function! s:paste_c_code()
  put =[
  \   'static const foo = 0;',
  \   '',
  \   'int Foo(void)',
  \   '{',
  \   '  return 1;',
  \   '  return 2;',
  \   '  return 3;',
  \   '}',
  \   '',
  \   '  static const bar = 1;',
  \   '',
  \   '  int Bar(void)',
  \   '  {',
  \   '    return 4;',
  \   '    return 5;',
  \   '    return 6;',
  \   '  }',
  \   '',
  \   'static const baz = 1;',
  \   '',
  \   'int Baz(void)',
  \   '{',
  \   '  return 4;',
  \   '  return 5;',
  \   '  return 6;',
  \   '}',
  \ ]
  1 delete _
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
    Expect line("'<") == 2
    Expect line("'>") == 8
    Expect visualmode() ==# 'V'
  end

  it 'selects the function under the cursor'
    " At the first line.
    normal! 3G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 2
    Expect line("'>") == 8
    Expect visualmode() ==# 'V'

    " At a middle line.
    normal! 6G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 2
    Expect line("'>") == 8
    Expect visualmode() ==# 'V'

    " At the last line.
    normal! 8G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 2
    Expect line("'>") == 8
    Expect visualmode() ==# 'V'
  end

  it 'does not recognize a function if it is deeply indented'
    normal! 15G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 20
    Expect line("'>") == 26
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
    Expect line("'<") == 5
    Expect line("'>") == 7
    Expect visualmode() ==# 'V'
  end

  it 'selects the content of the function under the cursor'
    " At the first line.
    normal! 3G
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

  it 'does not recognize a function if it is deeply indented'
    normal! 15G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 23
    Expect line("'>") == 25
    Expect visualmode() ==# 'V'
  end
end
