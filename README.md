# vim-textobj-function

[![Build Status](https://travis-ci.org/kana/vim-textobj-function.png)](https://travis-ci.org/kana/vim-textobj-function)




This is a Vim plugin to provide *text objects for functions*.
You can directly operate a function (`af`) or
the code inside a function (`if`).
For example,
`daf` to Delete A Function, or
`vif` to Visually select the code Inside a Function.

The syntax of a function is varied for each language.
Currently C language and Vim script are supported.
And this plugin is [pluggable](https://github.com/kana/vim-textobj-function/tree/master/after/ftplugin).
It's easy to support your favorite languages too.

See also [the reference manual](https://github.com/kana/vim-textobj-function/blob/master/doc/textobj-function.txt)
for more details.




<!-- vim: set expandtab shiftwidth=4 softtabstop=4 textwidth=78 : -->
