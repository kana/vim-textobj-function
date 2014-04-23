filetype plugin on
runtime! plugin/textobj/function.vim

function! s:paste_vim_code()
  read t/fixtures/sample.vim
endfunction

function! Select(line_number, object)
  call cursor(a:line_number, 1)
  execute 'normal' 'v'.a:object."\<Esc>"
  return [visualmode(), line("'<"), line("'>")]
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
    Expect Select(1, 'af') ==# ['v', 1, 1]
    Expect Select(7, 'if') ==# ['v', 7, 7]
  end

  it 'selects the function under the cursor'
    " At the first line.
    Expect Select(2, 'af') ==# ['V', 2, 6]

    " At a middle line.
    Expect Select(4, 'af') ==# ['V', 2, 6]

    " At the last line.
    Expect Select(6, 'af') ==# ['V', 2, 6]
  end

  it 'recognizes a function even if it is deeply indented'
    Expect Select(11, 'af') ==# ['V', 9, 13]
  end

  it 'can select a function without code'
    Expect Select(15, 'af') ==# ['V', 15, 16]
    Expect Select(16, 'af') ==# ['V', 15, 16]
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
    Expect Select(1, 'if') ==# ['v', 1, 1]
    Expect Select(7, 'if') ==# ['v', 7, 7]
  end

  it 'selects the content of the function under the cursor'
    " At the first line.
    Expect Select(2, 'if') ==# ['V', 3, 5]

    " At a middle line.
    Expect Select(4, 'if') ==# ['V', 3, 5]

    " At the last line.
    Expect Select(6, 'if') ==# ['V', 3, 5]
  end

  it 'recognizes a function even if it is deeply indented'
    Expect Select(11, 'if') ==# ['V', 10, 12]
  end

  it 'cannot select a function without code'
    Expect Select(15, 'if') ==# ['v', 15, 15]
    Expect Select(16, 'if') ==# ['v', 16, 16]
  end
end
