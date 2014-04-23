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

  describe 'in a vspec test script'
    it 'can select an outer :describe block'
      Expect Select(18, 'af') ==# ['V', 18, 49]
      Expect Select(35, 'af') ==# ['V', 18, 49]
      Expect Select(49, 'af') ==# ['V', 18, 49]
    end

    it 'can select an inner :describe block'
      Expect Select(19, 'af') ==# ['V', 19, 34]
      Expect Select(26, 'af') ==# ['V', 19, 34]
      Expect Select(30, 'af') ==# ['V', 19, 34]
      Expect Select(34, 'af') ==# ['V', 19, 34]
    end

    it 'can select a :before block'
      Expect Select(20, 'af') ==# ['V', 20, 25]
      Expect Select(21, 'af') ==# ['V', 20, 25]
      Expect Select(25, 'af') ==# ['V', 20, 25]
    end

    it 'can select an :after block'
      Expect Select(27, 'af') ==# ['V', 27, 29]
      Expect Select(28, 'af') ==# ['V', 27, 29]
      Expect Select(29, 'af') ==# ['V', 27, 29]
    end

    it 'can select an :it block'
      Expect Select(31, 'af') ==# ['V', 31, 33]
      Expect Select(32, 'af') ==# ['V', 31, 33]
      Expect Select(33, 'af') ==# ['V', 31, 33]
    end

    it 'can select a function in any block'
      Expect Select(22, 'af') ==# ['V', 22, 24]
      Expect Select(23, 'af') ==# ['V', 22, 24]
      Expect Select(24, 'af') ==# ['V', 22, 24]
    end

    it 'can select an empty :describe block'
      Expect Select(37, 'af') ==# ['V', 37, 38]
      Expect Select(38, 'af') ==# ['V', 37, 38]
    end

    it 'can select an empty :before block'
      Expect Select(40, 'af') ==# ['V', 40, 41]
      Expect Select(41, 'af') ==# ['V', 40, 41]
    end

    it 'can select an empty :after block'
      Expect Select(43, 'af') ==# ['V', 43, 44]
      Expect Select(44, 'af') ==# ['V', 43, 44]
    end

    it 'can select an empty :it block'
      Expect Select(46, 'af') ==# ['V', 46, 47]
      Expect Select(47, 'af') ==# ['V', 46, 47]
    end
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

  describe 'in a vspec test script'
    it 'can select an outer :describe block'
      Expect Select(18, 'if') ==# ['V', 19, 48]
      Expect Select(35, 'if') ==# ['V', 19, 48]
      Expect Select(49, 'if') ==# ['V', 19, 48]
    end

    it 'can select an inner :describe block'
      Expect Select(19, 'if') ==# ['V', 20, 33]
      Expect Select(26, 'if') ==# ['V', 20, 33]
      Expect Select(30, 'if') ==# ['V', 20, 33]
      Expect Select(34, 'if') ==# ['V', 20, 33]
    end

    it 'can select a :before block'
      Expect Select(20, 'if') ==# ['V', 21, 24]
      Expect Select(21, 'if') ==# ['V', 21, 24]
      Expect Select(25, 'if') ==# ['V', 21, 24]
    end

    it 'can select an :after block'
      Expect Select(27, 'if') ==# ['V', 28, 28]
      Expect Select(28, 'if') ==# ['V', 28, 28]
      Expect Select(29, 'if') ==# ['V', 28, 28]
    end

    it 'can select an :it block'
      Expect Select(31, 'if') ==# ['V', 32, 32]
      Expect Select(32, 'if') ==# ['V', 32, 32]
      Expect Select(33, 'if') ==# ['V', 32, 32]
    end

    it 'can select a function in any block'
      Expect Select(22, 'if') ==# ['V', 23, 23]
      Expect Select(23, 'if') ==# ['V', 23, 23]
      Expect Select(24, 'if') ==# ['V', 23, 23]
    end

    it 'cannot select an empty :describe block'
      Expect Select(37, 'if') ==# ['v', 37, 37]
      Expect Select(38, 'if') ==# ['v', 38, 38]
    end

    it 'cannot select an empty :before block'
      Expect Select(40, 'if') ==# ['v', 40, 40]
      Expect Select(41, 'if') ==# ['v', 41, 41]
    end

    it 'cannot select an empty :after block'
      Expect Select(43, 'if') ==# ['v', 43, 43]
      Expect Select(44, 'if') ==# ['v', 44, 44]
    end

    it 'cannot select an empty :it block'
      Expect Select(46, 'if') ==# ['v', 46, 46]
      Expect Select(47, 'if') ==# ['v', 47, 47]
    end
  end
end
