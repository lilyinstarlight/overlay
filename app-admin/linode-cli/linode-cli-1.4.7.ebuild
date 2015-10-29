# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Command-line interface to the Linode platform"
HOMEPAGE="https://www.linode.com/docs/platform/linode-cli"
MY_PN="${PN/linode-/}"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://github.com/linode/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-lang/perl
	dev-perl/JSON
	dev-perl/Mozilla-CA
	dev-perl/Try-Tiny
	dev-perl/LWP-UserAgent-Cached
	dev-perl/WebService-Linode
"
RDEPEND="
	${DEPEND}
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/systeminfo_gentoo.patch"
}

src_configure() {
	perl Makefile.PL PREFIX=/usr INSTALLSITEMAN1DIR=/usr/share/man/man1 INSTALLSITEMAN3DIR=/usr/share/man/man3
}

src_install() {
	emake DESTDIR="${D}" install
}
