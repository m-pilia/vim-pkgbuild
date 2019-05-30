if v:version < 600
    syntax clear
elseif exists('b:current_syntax')
    finish
endif

let b:main_syntax = 'sh'
let b:is_bash = 1

runtime! syntax/sh.vim
