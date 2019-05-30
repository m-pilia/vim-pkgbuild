Vim plugin to edit PKGBUILD files
=====================================================================

This plugin provides:
* filetype detection and syntax highlighting for PKGBUILD files;
* template for empty PKGBUILD files;
* a *Updpkgsums* command, to update the pkgsums in the current file;
* an [ALE](https://github.com/w0rp/ale) linter to run
  [shellcheck](https://github.com/koalaman/shellcheck) on PKGBUILD files
  without showing spurious errors due to PKGBUILD variables being undefined or
  unused (for available configuration options, please refer to
  |ale-sh-shellcheck|).

# Install

Install the plugin with your favourite plugin manager.

# License

This software is distributed under the MIT license. The full text of the license
is available in the [LICENSE
file](https://github.com/m-pilia/vim-pkgbuild/blob/master/LICENSE) distributed
alongside the source code.
