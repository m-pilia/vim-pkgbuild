" ALE linter to run shellcheck on PKGBUILD files

runtime! ale_linters/sh/shellcheck.vim

let s:pkgbuild_vars = [
\    'pkgbase',
\    'pkgname',
\    'pkgver',
\    'pkgrel',
\    'epoch',
\    'pkgdesc',
\    'arch',
\    'url',
\    'license',
\    'groups',
\    'depends',
\    'optdepends',
\    'makedepends',
\    'checkdepends',
\    'provides',
\    'conflicts',
\    'replaces',
\    'backup',
\    'options',
\    'install',
\    'changelog',
\    'source',
\    'noextract',
\    'validpgpkeys',
\    'md5sums',
\    'sha1sums',
\    'sha256sums',
\    'sha224sums',
\    'sha384sums',
\    'sha512sums',
\ ]

let s:unassigned_vars = [
\    'srcdir',
\    'pkgdir',
\    'startdir',
\ ]

let s:unused_pattern = '\v(' . join(s:pkgbuild_vars, '|') .  ') appears unused'
let s:unassigned_pattern = '\v(' . join(s:unassigned_vars, '|') .  ') is referenced but not assigned'

function! s:handle(buffer, lines) abort
    let l:output = []
    for l:item in ale_linters#sh#shellcheck#Handle(a:buffer, a:lines)
        if   match(l:item['text'], s:unused_pattern) < 0
        \ && match(l:item['text'], s:unassigned_pattern) < 0
            call add(l:output, l:item)
        endif
    endfor
    return l:output
endfunction

function! s:get_command(buffer, version) abort
    let l:cmd = ale_linters#sh#shellcheck#GetCommand(a:buffer, a:version)
    let l:cmd = substitute(l:cmd, '-s\s+\w+', '-s bash', '')
    return l:cmd
endfunction

call ale#linter#Define('PKGBUILD', {
\   'name': 'shellcheck',
\   'executable': {buffer -> ale#Var(buffer, 'sh_shellcheck_executable')},
\   'command': {buffer -> ale#semver#RunWithVersionCheck(
\       buffer,
\       ale#Var(buffer, 'sh_shellcheck_executable'),
\       '%e --version',
\       function('s:get_command'),
\   )},
\   'callback': function('s:handle'),
\})
