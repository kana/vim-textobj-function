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
    normal! 2G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 4
    Expect line("'>") == 9
    Expect visualmode() ==# 'V'
  end

  it 'selects the method under the cursor'
    " At the first line.
    normal! 4G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 4
    Expect line("'>") == 9
    Expect visualmode() ==# 'V'

    " At a middle line.
    normal! 7G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 4
    Expect line("'>") == 9
    Expect visualmode() ==# 'V'

    " At the last line.
    normal! 9G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 4
    Expect line("'>") == 9
    Expect visualmode() ==# 'V'
  end

  it 'ignores non-method blocks'
    normal! 17G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 11
    Expect line("'>") == 21
    Expect visualmode() ==# 'V'
  end

  it 'recognizes methods with one-line prototypes'
    normal! 26G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 23
    Expect line("'>") == 28
    Expect visualmode() ==# 'V'

    normal! 32G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 30
    Expect line("'>") == 34
    Expect visualmode() ==# 'V'
  end

  it 'recognizes methods with argument lists over multiple lines'
    normal! 40G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 36
    Expect line("'>") == 42
    Expect visualmode() ==# 'V'

    normal! 47G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 44
    Expect line("'>") == 49
    Expect visualmode() ==# 'V'
  end

  it 'recognizes methods with argument lists placed after method name lines'
    normal! 57G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 51
    Expect line("'>") == 59
    Expect visualmode() ==# 'V'

    normal! 66G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 61
    Expect line("'>") == 68
    Expect visualmode() ==# 'V'
  end

  it 'fails if there is no appropriate method'
    normal! 76G
    execute 'normal' "vaf\<Esc>"
    Expect line("'<") == 76
    Expect line("'>") == 76
    Expect visualmode() ==# 'v'
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
    normal! 2G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 6
    Expect line("'>") == 8
    Expect visualmode() ==# 'V'
  end

  it 'selects the method under the cursor'
    " At the first line.
    normal! 4G
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

  it 'ignores non-method blocks'
    normal! 17G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 13
    Expect line("'>") == 20
    Expect visualmode() ==# 'V'
  end

  it 'recognizes methods with one-line prototypes'
    normal! 26G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 25
    Expect line("'>") == 27
    Expect visualmode() ==# 'V'

    normal! 32G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 31
    Expect line("'>") == 33
    Expect visualmode() ==# 'V'
  end

  it 'recognizes methods with argument lists over multiple lines'
    normal! 40G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 39
    Expect line("'>") == 41
    Expect visualmode() ==# 'V'

    normal! 47G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 46
    Expect line("'>") == 48
    Expect visualmode() ==# 'V'
  end

  it 'recognizes methods with argument lists placed after method name lines'
    normal! 57G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 56
    Expect line("'>") == 58
    Expect visualmode() ==# 'V'

    normal! 66G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 65
    Expect line("'>") == 67
    Expect visualmode() ==# 'V'
  end

  it 'fails if the target method does not contain any code'
    normal! 70G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 70
    Expect line("'>") == 70
    Expect visualmode() ==# 'v'

    normal! 74G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 74
    Expect line("'>") == 74
    Expect visualmode() ==# 'v'
  end

  it 'fails if there is no appropriate method'
    normal! 76G
    execute 'normal' "vif\<Esc>"
    Expect line("'<") == 76
    Expect line("'>") == 76
    Expect visualmode() ==# 'v'
  end
end
