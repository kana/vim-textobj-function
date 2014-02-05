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
  \   '',
  \   'int OtherFoo(void) {',
  \   '   return 7;',
  \   '   return 8;',
  \   '   return 9;',
  \   '}',
  \   '',
  \   'int OtherFoo(',
  \   '    int a,',
  \   '    char b',
  \   ') {',
  \   '   return 7;',
  \   '   return 8;',
  \   '   return 9;',
  \   '}'
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

  it 'works with alternative brace styles'
    " With a one-line prototype
    normal! 27G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 27
    Expect line("'>") == 32
    Expect visualmode() ==# 'V'

    " With a more complex prototype
    normal! 39G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 33
    Expect line("'>") == 41
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

  it 'works with alternative brace styles'
    " With a one-line prototype
    normal! 28G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 29
    Expect line("'>") == 31
    Expect visualmode() ==# 'V'

    " With a more complex prototype
    normal! 39G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 38
    Expect line("'>") == 40
    Expect visualmode() ==# 'V'
  end
end
