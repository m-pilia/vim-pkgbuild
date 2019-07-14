let s:template_file = expand('<sfile>:p:h:h') . '/template/PKGBUILD'

function! s:warn(message) abort
    redraw
    echohl WarningMsg
    echom 'vim-pkgbuild: ' . a:message
    echohl None
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

    let l:redirect = g:vim_pkgbuild_silent ? ' >/dev/null 2>&1' : ''

    silent! execute '!updpkgsums "' . expand('%:p') . '"' . l:redirect
    redraw!
    edit!
endfunction

function! PKGBUILD#load_template() abort
    silent execute '0r ' . s:template_file
    set modified
endfunction
