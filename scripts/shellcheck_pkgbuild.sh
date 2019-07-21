#!/usr/bin/env bash

function join() {
	local IFS="$1"
	shift
	echo "$*"
}

# Check if shellcheck supports the '-x' flag
x_flag=
if [ "$(shellcheck 2>&1 | grep -Ee '^\s*-x' | wc -c)" -gt 0 ]; then
	x_flag=-x
fi

# SC2164 is not necessary, since PKGBUILD runs with `set -e`
exclude=(
	'-e' 'SC2164'
)

pkgbuild_vars=(
	'pkgbase'
	'pkgname'
	'pkgver'
	'pkgrel'
	'epoch'
	'pkgdesc'
	'arch'
	'url'
	'license'
	'groups'
	'depends'
	'optdepends'
	'makedepends'
	'checkdepends'
	'provides'
	'conflicts'
	'replaces'
	'backup'
	'options'
	'install'
	'changelog'
	'source'
	'noextract'
	'validpgpkeys'
	'md5sums'
	'sha1sums'
	'sha256sums'
	'sha224sums'
	'sha384sums'
	'sha512sums'
)
pkgbuild_vars_joined=$(join '|' "${pkgbuild_vars[@]}")
unused_pattern=$(printf "(%s) appears unused" "$pkgbuild_vars_joined")

unassigned_vars=(
	'srcdir'
	'pkgdir'
	'startdir'
)
unassigned_vars_joined=$(join '|' "${unassigned_vars[@]}")
unassigned_pattern=$(printf "(%s) is referenced but not assigned" "$unassigned_vars_joined")

shellcheck -s bash -f gcc $x_flag "${exclude[@]}" "$@" \
	| grep -Ev "$unused_pattern" \
	| grep -Ev "$unassigned_pattern"
