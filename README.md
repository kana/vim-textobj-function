# vim-textobj-function

[![Build Status](https://travis-ci.org/kana/vim-textobj-function.png)](https://travis-ci.org/kana/vim-textobj-function)




vim-textobj-function is a Vim plugin to **text objects for functions**.  You can
directly target a function (`af`) or the code inside a function (`if`).
For example,

* `daf` to **D**elete **A** **F**unction, and
* `vif` to **V**isually select the code **I**nside a **F**unction.

The syntax of a "function" is varied for each language.  So that you have to
tell the syntax of a function to vim-textobj-function before editing.  By
default, the following languages are supported:

* C language
* Java
* Vim script
  (including [vim-vspec](https://github.com/kana/vim-vspec)-specific syntax)

To support new languages, see:

* [The reference manual](https://github.com/kana/vim-textobj-function/blob/master/doc/textobj-function.txt)
* [The implementation for currently supported languages](https://github.com/kana/vim-textobj-function/tree/master/after/ftplugin)




<!-- vim: set expandtab shiftwidth=4 softtabstop=4 textwidth=78 : -->
