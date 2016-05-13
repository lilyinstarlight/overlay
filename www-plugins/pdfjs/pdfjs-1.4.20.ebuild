# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="a general-purpose, web standards-based platform for parsing and rendering PDFs"
HOMEPAGE="http://mozilla.github.io/pdf.js/"
SRC_URI="https://github.com/mozilla/pdf.js/releases/download/v${PV}/${P}-dist.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"

src_install() {
	insinto /usr/share/pdf.js/

	doins -r build
	doins -r web
}
