# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Share your terminal as a web application"
HOMEPAGE="https://github.com/yudai/gotty"
MY_PN="${PN/-bin/}"
SRC_URI="https://github.com/yudai/${MY_PN}/releases/download/v${PV}/${MY_PN}_linux_amd64.tar.gz -> ${P}_linux_amd64.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"

src_install() {
	dobin ${MY_PN}
}
