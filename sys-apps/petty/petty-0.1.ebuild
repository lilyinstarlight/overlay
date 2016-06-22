# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="petty, short for practically enhanced tty, is a tty session starter"
HOMEPAGE="https://github.com/fkmclane/petty"
SRC_URI="https://github.com/fkmclane/${PN}/archive/v${PV}.tar.gz"

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

	insinto /usr/share/sessions
	doins sessions/xsession
}

pkg_postinst() {
	if [ ! "`grep /usr/bin/petty /etc/shells`" ]; then
		ebegin "Updating /etc/shells"
		echo "/usr/bin/petty" >>/etc/shells;
		eend $?
	fi
}

pkg_postrm() {
	ex "+g#/usr/bin/petty#d" -cwq /etc/shells
}
