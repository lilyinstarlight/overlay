# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit perl-module

DESCRIPTION="web sesrver vulnerability scanner"
HOMEPAGE="http://www.cirt.net/Nikto2"
SRC_URI="http://www.cirt.net/nikto/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ssl"

DEPEND=""
RDEPEND="
	!net-libs/libwhisker
	dev-lang/perl
	ssl? (
		dev-libs/openssl:0=
		dev-perl/Net-SSLeay
	)
"

src_prepare() {
	sed -i -e 's:config.txt:nikto.conf:g' plugins/* || die
	sed -i -e 's:/etc/nikto.conf:/etc/nikto/nikto.conf:;' nikto.pl
	sed -i -e 's:# EXECDIR=/opt/nikto:EXECDIR=/usr/share/nikto:;' nikto.conf
	sed -i -e 's:# PLUGINDIR=/opt/nikto/plugins:PLUGINDIR=/usr/share/nikto/plugins:;' nikto.conf
	sed -i -e 's:# DBDIR=/opt/nikto/databases:DBDIR=/usr/share/nikto/databases:;' nikto.conf
	sed	-i -e 's:# TEMPLATEDIR=/opt/nikto/templates:TEMPLATEDIR=/usr/share/nikto/databases:;' nikto.conf

	default
}

src_install() {
	insinto /etc/nikto
	doins nikto.conf

	dobin nikto.pl
	dosym nikto.pl /usr/bin/nikto

	insinto /usr/share/nikto
	doins -r plugins templates databases

	NIKTO_PMS='JSON-PP.pm LW2.pm'
	einfo "symlinking ${NIKTO_PMS} to ${VENDOR_LIB}"

	for PM in ${NIKTO_PMS}; do
		TARGET=${VENDOR_LIB}/${PM}
		dosym /usr/share/nikto/plugins/${PM} ${TARGET}
	done

	dodoc docs/*.txt

	docinto /usr/share/${P}/html
	dodoc docs/nikto_manual.html
}
