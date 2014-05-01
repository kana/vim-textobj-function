source t/helpers/setup.vim

describe '<Plug>(textobj-function-a)'
  before
    new
    setfiletype java
    call PasteSampleCode('java')
  end

  after
    close!
  end

  it 'selects the next method if there is no method under the cursor'
    Expect Select(2, 'af') ==# ['V', 4, 9]
  end

  it 'selects the method under the cursor'
    " At the first line.
    Expect Select(4, 'af') ==# ['V', 4, 9]

    " At a middle line.
    Expect Select(7, 'af') ==# ['V', 4, 9]

    " At the last line.
    Expect Select(9, 'af') ==# ['V', 4, 9]
  end

  it 'ignores non-method blocks'
    Expect Select(17, 'af') ==# ['V', 11, 21]
  end

  it 'recognizes methods with one-line prototypes'
    Expect Select(26, 'af') ==# ['V', 23, 28]

    Expect Select(32, 'af') ==# ['V', 30, 34]
  end

  it 'recognizes methods with argument lists over multiple lines'
    Expect Select(40, 'af') ==# ['V', 36, 42]

    Expect Select(47, 'af') ==# ['V', 44, 49]
  end

  it 'recognizes methods with argument lists placed after method name lines'
    Expect Select(57, 'af') ==# ['V', 51, 59]

    Expect Select(66, 'af') ==# ['V', 61, 68]
  end

  it 'fails if there is no appropriate method'
    Expect Select(76, 'af') ==# ['v', 76, 76]
  end
end

describe '<Plug>(textobj-function-i)'
  before
    new
    setfiletype java
    call PasteSampleCode('java')
  end

  after
    close!
  end

  it 'selects the next method if there is no method under the cursor'
    Expect Select(2, 'if') ==# ['V', 6, 8]
  end

  it 'selects the method under the cursor'
    " At the first line.
    Expect Select(4, 'if') ==# ['V', 6, 8]

    " At a middle line.
    Expect Select(7, 'if') ==# ['V', 6, 8]

    " At the last line.
    Expect Select(9, 'if') ==# ['V', 6, 8]
  end

  it 'ignores non-method blocks'
    Expect Select(17, 'if') ==# ['V', 13, 20]
  end

  it 'recognizes methods with one-line prototypes'
    Expect Select(26, 'if') ==# ['V', 25, 27]

    Expect Select(32, 'if') ==# ['V', 31, 33]
  end

  it 'recognizes methods with argument lists over multiple lines'
    Expect Select(40, 'if') ==# ['V', 39, 41]

    Expect Select(47, 'if') ==# ['V', 46, 48]
  end

  it 'recognizes methods with argument lists placed after method name lines'
    Expect Select(57, 'if') ==# ['V', 56, 58]

    Expect Select(66, 'if') ==# ['V', 65, 67]
  end

  it 'fails if the target method does not contain any code'
    Expect Select(70, 'if') ==# ['v', 70, 70]

    Expect Select(74, 'if') ==# ['v', 74, 74]
  end

  it 'fails if there is no appropriate method'
    Expect Select(76, 'if') ==# ['v', 76, 76]
  end
end
