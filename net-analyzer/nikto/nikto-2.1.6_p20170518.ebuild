# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="web server vulnerability scanner"
HOMEPAGE="http://www.cirt.net/Nikto2"
COMMIT="a44bae3ce300b884f1b476fd2e78a779a276b2b0"
MY_P="${PN}-${COMMIT}"
SRC_URI="https://github.com/sullo/nikto/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~amd64-linux ~x86-linux ~x86-macos"
IUSE="ssl"

RDEPEND="
	dev-lang/perl
	virtual/perl-JSON-PP
	net-analyzer/nmap
	ssl? (
		dev-libs/openssl
		dev-perl/Net-SSLeay
	)
"

S="${WORKDIR}/${MY_P}/program"

src_prepare() {
	sed -i -e 's:config.txt:nikto.conf:g' plugins/* || die
	sed -i -e 's:/etc/nikto.conf:/etc/nikto/nikto.conf:' nikto.pl || die
	sed -i -e 's:# EXECDIR=/opt/nikto:EXECDIR=/usr/share/nikto:' nikto.conf || die

	default
}

src_install() {
	insinto /etc/nikto
	doins nikto.conf

	dobin nikto.pl replay.pl
	dosym /usr/bin/nikto.pl /usr/bin/nikto

	dodir /usr/share/nikto
	insinto /usr/share/nikto
	doins -r plugins templates databases

	dodoc docs/*.txt
	dodoc docs/nikto_manual.html
}
