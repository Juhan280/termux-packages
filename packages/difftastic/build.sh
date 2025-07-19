TERMUX_PKG_HOMEPAGE="https://github.com/Wilfred/difftastic"
TERMUX_PKG_DESCRIPTION="difft: A structural diff that understands syntax"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_LICENSE_FILE="LICENSE"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="0.65.0"
TERMUX_PKG_SRCURL="https://github.com/Wilfred/difftastic/archive/refs/tags/$TERMUX_PKG_VERSION.tar.gz"
TERMUX_PKG_SHA256=59462f69e2cedfdc1bee4fd0da48fe9a7ae635cdb6818c1a300b31c0b146d4b8
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libc++"
TERMUX_PKG_BUILD_IN_SRC=true
# needed for MIME database (optional in upstream)
TERMUX_PKG_RECOMMENDS="file"

TREESITTER_NU_COMMIT=6544c4383643cf8608d50def2247a7af8314e148
TREESITTER_NU_SRCURL=https://github.com/nushell/tree-sitter-nu/archive/$TREESITTER_NU_COMMIT.zip
TREESITTER_NU_SHA256=199c6580480d4b74053ad3c3b11d17e338dfebc202e841d0fa3d3c1a791d28c2

termux_step_post_get_source() {
	termux_download $TREESITTER_NU_SRCURL tree-sitter-nu.zip $TREESITTER_NU_SHA256
	unzip tree-sitter-nu.zip
	mv tree-sitter-nu-$TREESITTER_NU_COMMIT "$TERMUX_PKG_SRCDIR/vendored_parsers/tree-sitter-nu"
}

termux_step_post_make_install() {
	install -Dm644 -t "$TERMUX_PREFIX/share/man/man1/" difft.1
}
