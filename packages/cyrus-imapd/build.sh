TERMUX_PKG_HOMEPAGE=https://www.cyrusimap.org/
TERMUX_PKG_DESCRIPTION="Cyrus IMAPd - IMAP and JMAP server."
TERMUX_PKG_LICENSE="BSD"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=3.12.1
TERMUX_PKG_SRCURL=https://github.com/cyrusimap/cyrus-imapd/archive/cyrus-imapd-${TERMUX_PKG_VERSION}/cyrus-imapd-${TERMUX_PKG_VERSION}.zip
TERMUX_PKG_SHA256=bae420bcc388b2a899c8381cc635da84d8bee44cbf745f47d4e906f910892581
TERMUX_PKG_BUILD_DEPENDS="autoconf, automake, make, clang"
TERMUX_PKG_DEPENDS="libicu, libical, libjansson, libsasl"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--disable-squat"
TERMUX_PKG_MAKE_PROCESSES=$(nproc)

termux_step_pre_configure() {
	sed -i 's/ulong/unsigned long/g' imap/*
	autoreconf -fi
	local _libgcc_file="$($CC -print-libgcc-file-name)"
	local _libgcc_path="$(dirname $_libgcc_file)"
	local _libgcc_name="$(basename $_libgcc_file)"
	LDFLAGS+=" -L$_libgcc_path -l:$_libgcc_name"
}
