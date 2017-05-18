# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Rofi frontend for pass"
HOMEPAGE="https://github.com/carnager/rofi-pass"
SRC_URI="https://github.com/carnager/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	app-admin/pass
	x11-misc/rofi
	x11-misc/xdotool
"

src_compile() {
	# nop
	true
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr"
}
