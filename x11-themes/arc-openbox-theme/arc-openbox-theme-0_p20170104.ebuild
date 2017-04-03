# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Openbox theme created to fit in nicely with the Arc GTK theme"
HOMEPAGE="https://github.com/dglava/arc-openbox"
MY_PN="arc-openbox"
COMMIT="d6bfa0ec2dedee3f45c263b01b7eeb9635402ac3"
MY_P="${MY_PN}-${COMMIT}"
SRC_URI="https://github.com/dglava/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_install() {
	insinto /usr/share/themes/Arc
	doins -r Arc/openbox-3

	insinto /usr/share/themes/Arc-Dark
	doins -r Arc-Dark/openbox-3
}
