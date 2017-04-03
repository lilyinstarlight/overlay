# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="petty, short for practically enhanced tty, is a tty session starter"
HOMEPAGE="https://github.com/fkmclane/petty"
SRC_URI="https://github.com/fkmclane/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	# no-op
	true
}

src_install() {
	dobin bin/petty
	dobin bin/xsession

	dodir /usr/share/sessions

	exeinto /usr/share/sessions
	doexe sessions/xsession
}

pkg_postinst() {
	if [ ! "`grep /usr/bin/petty /etc/shells`" ]; then
		ebegin "Updating /etc/shells"
		echo "/usr/bin/petty" >>/etc/shells;
		eend $?
	fi
}

pkg_postrm() {
	ebegin "Updating /etc/shells"
	ex "+g#/usr/bin/petty#d" -cwq /etc/shells
	eend $?
}
