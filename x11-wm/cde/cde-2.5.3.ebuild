EAPI=8

inherit autotools

DESCRIPTION="The Common Desktop Environment"
HOMEPAGE="https://github.com/cdesktopenv/cde"
SRC_URI="https://github.com/cdesktopenv/cde/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+docs"

DEPEND="
	app-arch/ncompress
	app-shells/ksh
	dev-lang/perl
	dev-lang/tcl
	dev-libs/libtirpc
	dev-libs/lmdb
	dev-libs/openssl
	media-libs/libjpeg-turbo
	net-nds/rpcbind
	sys-devel/bison
	sys-devel/flex
	sys-devel/m4
	sys-libs/libutempter
	sys-libs/pam
	virtual/libcrypt
	x11-apps/bdftopcf
	x11-apps/mkfontdir
	x11-apps/sessreg
	x11-apps/xrdb
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXinerama
	x11-libs/libXmu
	x11-libs/libXpm
	x11-libs/libXrender
	x11-libs/libXt
	x11-libs/motif
	docs? ( app-text/opensp )
"

RDEPEND="
	app-shells/ksh
	dev-lang/tcl
	dev-libs/libtirpc
	dev-libs/lmdb
	media-libs/libjpeg-turbo
	sys-libs/libutempter
	sys-libs/pam
	x11-apps/sessreg
	x11-apps/xrdb
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXinerama
	x11-libs/libXmu
	x11-libs/libXpm
	x11-libs/libXrender
	x11-libs/libXt
	x11-libs/motif
"

BDEPEND="
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
"

S="${WORKDIR}/cde-${PV}"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	econf \
		--prefix=/usr \
		--with-cde-data-dir=/usr/share/cde \
		--with-cde-config-dir=/etc/dt \
		--with-cde-state-dir=/var/dt \
		--with-cde-libexec-dir=/usr/libexec/cde \
		$(use_enable docs)
}

src_install() {
	emake DESTDIR="${D}" install

	insinto /usr/share/xsessions
	doins contrib/desktopentry/cde.desktop

	keepdir /var/dt/appconfig/appmanager
	dodoc COPYING HISTORY README.md
}
