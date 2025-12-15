TERMUX_PKG_HOMEPAGE=https://carapace-sh.github.io/carapace-spec/
TERMUX_PKG_DESCRIPTION="A multi-shell completion spec."
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.4.2"
TERMUX_PKG_SRCURL=https://github.com/carapace-sh/carapace-spec/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=248c50ae6128e927d68992335e796c65816b0a7de7e275a9b43c1136d7927fcd
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_AUTO_UPDATE=true

termux_step_pre_configure() {
	termux_setup_golang
}

termux_step_make() {
	# ( # Do this in a subshell to not mess with the variables for the main build.
	# 	# `go generate` needs to run on the host machine
	# 	# so we borrow a trick from gh and glow's package builds
	# 	unset GOOS GOARCH CGO_LDFLAGS
	# 	unset CC CXX CFLAGS CXXFLAGS LDFLAGS
	#
	# 	go generate ./cmd/carapace-spec/...
	# )
	go generate ./cmd/carapace-spec/...
	go build -v -ldflags="-X main.version=v${TERMUX_PKG_VERSION} -s -w" -tags release ./cmd/carapace-spec
}

termux_step_make_install() {
	install -Dm700 carapace-spec "$TERMUX_PREFIX/bin/carapace-spec"
}
