Vim plugin to edit PKGBUILD files
=====================================================================

This plugin provides:
* filetype detection and syntax highlighting for PKGBUILD files;
* template for empty PKGBUILD files;
* a *Updpkgsums* command, to update the pkgsums in the current file;
* a linter to run [shellcheck](https://github.com/koalaman/shellcheck) on
  PKGBUILD files without showing spurious errors due to PKGBUILD variables
  being undefined or unused. The path to the linter executable can be retrieved
  by calling `PKGBUILD#shellcheck()`. The plugin also provides out-of-the-box
  integration with [ALE](https://github.com/w0rp/ale).

# Install

Install the plugin with your favourite plugin manager.

# License

This software is distributed under the MIT license. The full text of the license
is available in the [LICENSE
file](https://github.com/m-pilia/vim-pkgbuild/blob/master/LICENSE) distributed
alongside the source code.
