# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils java-pkg-2

DESCRIPTION="Decompiler and editor of Flash SWF files"
HOMEPAGE="https://www.free-decompiler.com/flash/"
SRC_URI="https://www.free-decompiler.com/flash/download/ffdec_10.0.0.zip"

LICENSE="GPL-3 GPL-2 LGPL-2.1 MIT Apache-2.0 CC-BY-3.0 CC-BY-SA-2.5 BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
DEPEND="virtual/jre:1.8"

S="${WORKDIR}"

src_compile() {
	# nop
	true
}

src_install() {
	java-pkg_dojar "${PN}".jar
	java-pkg_dojar lib/*.jar

	java-pkg_dolauncher "${PN}" --main com.jpexs.decompiler.flash.gui.Main

	newicon icon.png ffdec.png
	make_desktop_entry "${PN}" FFDec "${PN}" 'Development;Utility;WebDevelopment'
}
