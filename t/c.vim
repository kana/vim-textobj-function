source t/helpers/setup.vim

describe '<Plug>(textobj-function-a)'
  before
    new
    setfiletype c
    call PasteSampleCode('c')
  end

  after
    close!
  end

  it 'selects the next function if there is no function under the cursor'
    Expect Select(1, 'af') ==# ['V', 3, 9]
  end

  it 'selects the function under the cursor'
    " At the first line.
    Expect Select(3, 'af') ==# ['V', 3, 9]

    " At a middle line.
    Expect Select(7, 'af') ==# ['V', 3, 9]

    " At the last line.
    Expect Select(9, 'af') ==# ['V', 3, 9]
  end

  it 'does not recognize a function if it is deeply indented'
    Expect Select(17, 'af') ==# ['V', 23, 29]
  end

  it 'recognizes functinos with alternative brace style'
    " With a one-line prototype
    Expect Select(34, 'af') ==# ['V', 31, 36]

    " With a more complex prototype
    Expect Select(44, 'af') ==# ['V', 38, 46]
  end
end

describe '<Plug>(textobj-function-i)'
  before
    new
    setfiletype c
    call PasteSampleCode('c')
  end

  after
    close!
  end

  it 'selects the content of the next function if the cursor is not on one'
    Expect Select(1, 'if') ==# ['V', 6, 8]
  end

  it 'selects the content of the function under the cursor'
    " At the first line.
    Expect Select(3, 'if') ==# ['V', 6, 8]

    " At a middle line.
    Expect Select(7, 'if') ==# ['V', 6, 8]

    " At the last line.
    Expect Select(9, 'if') ==# ['V', 6, 8]
  end

  it 'does not recognize a function if it is deeply indented'
    Expect Select(17, 'if') ==# ['V', 26, 28]
  end

  it 'recognizes functinos with alternative brace style'
    " With a one-line prototype
    Expect Select(34, 'if') ==# ['V', 33, 35]

    " With a more complex prototype
    Expect Select(44, 'if') ==# ['V', 43, 45]
  end
end
