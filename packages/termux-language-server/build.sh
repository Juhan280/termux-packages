TERMUX_PKG_HOMEPAGE=https://termux-language-server.readthedocs.io/en/latest/
TERMUX_PKG_DESCRIPTION="Language server for build.sh, PKGBUILD, ebuild"
TERMUX_PKG_LICENSE="GPL-3.0-only" # TODO: use correct license
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="0.0.31"
TERMUX_PKG_SRCURL=https://github.com/termux/termux-language-server/archive/refs/tags/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=08dac404426bf93429a2b1f2f5a5f17f43d3459f593329e5c5acabe545bf0537
TERMUX_PKG_DEPENDS="python, python-pip"
TERMUX_PKG_PYTHON_TARGET_DEPS="fqdn, lsp-tree-sitter, platformdirs, rfc3987, tree-sitter-bash, pyalpm, license-expression, portage"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_AUTO_UPDATE=true

termux_step_make() {
	:
}

termux_step_make_install() {
	pip install . --prefix=$TERMUX_PREFIX -vv --no-build-isolation --no-deps
}

termux_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!$TERMUX_PREFIX/bin/sh
		echo "Installing dependencies through pip..."
		pip3 install ${TERMUX_PKG_PYTHON_TARGET_DEPS//, / }
	EOF
}
