# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Tiling window manager based on binary space partitioning"
HOMEPAGE="https://github.com/baskerville/bspwm/"
COMMIT="ae76469130ec3f9a827d1bf807f7dd569b8f5376"
MY_P="${PN}-${COMMIT}"
SRC_URI="https://github.com/baskerville/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND="
	x11-libs/libxcb
	x11-libs/xcb-util
	x11-libs/xcb-util-wm
"
RDEPEND="
	${DEPEND}
	x11-misc/sxhkd
"

S="${WORKDIR}/${MY_P}"

src_compile() {
	emake PREFIX=/usr CC="$(tc-getCC)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
	dodoc doc/{CONTRIBUTING,MISC,TODO}.md

	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}"/${PN}-session ${PN}

	insinto /usr/share/xsessions
	doins contrib/freedesktop/bspwm.desktop

	insinto /etc/xdg/sxhkd
	doins examples/sxhkdrc

	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
