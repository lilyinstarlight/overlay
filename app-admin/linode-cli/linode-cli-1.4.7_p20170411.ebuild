# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Command-line interface to the Linode platform"
HOMEPAGE="https://www.linode.com/docs/platform/linode-cli"
MY_PN="${PN/linode-/}"
MY_PV="7e1b3de1716f9dfb727e716a9068cbbd21ab6386"
MY_P="${MY_PN}-${MY_PV}"
SRC_URI="https://github.com/linode/${MY_PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

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

	default
}

src_configure() {
	perl Makefile.PL PREFIX=/usr INSTALLSITEMAN1DIR=/usr/share/man/man1 INSTALLSITEMAN3DIR=/usr/share/man/man3 || die
}

src_install() {
	emake DESTDIR="${D}" install
}
