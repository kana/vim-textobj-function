filetype plugin on
runtime! plugin/textobj/function.vim

function! s:paste_vim_code()
  put =[
  \   'let Foo = 0',
  \   'function Foo()',
  \   '  return 1',
  \   '  return 2',
  \   '  return 3',
  \   'endfunction',
  \   '',
  \   '  let Bar = 0',
  \   '  function Bar()',
  \   '    return 4',
  \   '    return 5',
  \   '    return 6',
  \   '  endfunction',
  \ ]
  1 delete _
endfunction

describe '<Plug>(textobj-function-a)'
  before
    new
    setfiletype vim
    call s:paste_vim_code()
  end

  after
    close!
  end

  it 'fails if the cursor is not in a function'
    normal! 1G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 1
    Expect line("'>") == 1
    Expect visualmode() ==# 'v'
  end

  it 'selects the function under the cursor'
    " At the first line.
    normal! 2G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 2
    Expect line("'>") == 6
    Expect visualmode() ==# 'V'

    " At a middle line.
    normal! 4G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 2
    Expect line("'>") == 6
    Expect visualmode() ==# 'V'

    " At the last line.
    normal! 6G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 2
    Expect line("'>") == 6
    Expect visualmode() ==# 'V'
  end

  it 'recognizes a function even if it is deeply indented'
    normal! 11G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 9
    Expect line("'>") == 13
    Expect visualmode() ==# 'V'
  end
end

describe '<Plug>(textobj-function-i)'
  before
    new
    setfiletype vim
    call s:paste_vim_code()
  end

  after
    close!
  end

  it 'fails if the cursor is not in a function'
    normal! 1G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 1
    Expect line("'>") == 1
    Expect visualmode() ==# 'v'
  end

  it 'selects the content of the function under the cursor'
    " At the first line.
    normal! 2G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 3
    Expect line("'>") == 5
    Expect visualmode() ==# 'V'

    " At a middle line.
    normal! 4G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 3
    Expect line("'>") == 5
    Expect visualmode() ==# 'V'

    " At the last line.
    normal! 6G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 3
    Expect line("'>") == 5
    Expect visualmode() ==# 'V'
  end

  it 'recognizes a function even if it is deeply indented'
    normal! 11G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 10
    Expect line("'>") == 12
    Expect visualmode() ==# 'V'
  end
end
