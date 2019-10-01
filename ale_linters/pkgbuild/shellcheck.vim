" ALE linter to run shellcheck on PKGBUILD files

runtime! ale_linters/sh/shellcheck.vim

call ale#linter#Define('pkgbuild', {
\   'name': 'shellcheck',
\   'executable': pkgbuild#shellcheck(),
\   'command': '%e %t',
\   'callback': 'ale_linters#sh#shellcheck#Handle',
\})
