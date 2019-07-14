if exists('g:loaded_vim_pkgbuild_plugin')
    finish
endif
let g:loaded_vim_pkgbuild_plugin = 1

if !exists('g:vim_pkgbuild_silent')
    let g:vim_pkgbuild_silent = 0
endif

command! -nargs=0 -bar -bang Updpkgsums call PKGBUILD#updpkgsums("<bang>")

augroup vim_pkgbuild
    autocmd!
    autocmd BufNewFile PKGBUILD call PKGBUILD#load_template()
augroup END
