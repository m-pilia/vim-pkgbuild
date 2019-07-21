let s:template_file = expand('<sfile>:p:h:h') . '/template/PKGBUILD'
let s:linter = expand('<sfile>:p:h:h') . '/scripts/shellcheck_pkgbuild.sh'

function! s:warn(message) abort
    redraw
    echohl WarningMsg
    echom 'vim-pkgbuild: ' . a:message
    echohl None
endfunction

function! s:check_exit_status(job, status, ...) abort
    if a:status != 0
        call s:warn('Failed to update checksums')
        return
    endif

    echom 'Checksums updated'
    edit!
endfunction

function! s:echo_line(channel, message) abort
    if !g:vim_pkgbuild_silent
        echom a:message
    endif
endfunction

function! s:nvim_callback(channel, data, stream) abort
    if g:vim_pkgbuild_silent
        return
    endif

    for l:line in a:data
        call s:echo_line(0, l:line)
    endfor
endfunction

function! PKGBUILD#updpkgsums(bang) abort
    if !executable('updpkgsums')
        call s:warn('updpkgsums executable unavailable')
        return
    endif

    if &modified
        if a:bang ==# ''
            call s:warn('no write since last change')
            return
        else
            write!
        endif
    endif

    let l:command = 'updpkgsums "' . expand('%:p') . '" 2>&1'

    if has('nvim')
        call jobstart(l:command, {
        \   'on_stdout': function('s:nvim_callback'),
        \   'on_exit': function('s:check_exit_status'),
        \   'stdout_buffered': 1,
        \ })
    else
        if !has('job')
            echoerr 'Requires |+job|'
            return
        endif

        call job_start(l:command, {
        \   'out_cb': function('s:echo_line'),
        \   'exit_cb': function('s:check_exit_status'),
        \ })
    endif
endfunction

function! PKGBUILD#load_template() abort
    silent execute '0r ' . s:template_file
    set modified
endfunction

" Return the path to the shellcheck linter for PKGBUILD
function! PKGBUILD#shellcheck() abort
    return s:linter
endfunction

" Return settings dictionary for diagnostic-languageserver
function! PKGBUILD#diagnostic_languageserver() abort
    return {
    \   'command': s:linter,
    \   'args': ['%file'],
    \   'sourceName': 'shellcheck',
    \   'formatPattern': [
    \       '^[^:]+:(\d+):(\d+):\s+([^:]+):\s+(.*)$',
    \       {
    \           'line': 1,
    \           'column': 2,
    \           'message': 4,
    \           'security': 3,
    \       },
    \   ],
    \   'securities': {
    \       'error': 'error',
    \       'warning': 'warning',
    \       'note': 'info',
    \   },
    \ }
endfunction
