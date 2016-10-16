# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Openbox theme created to fit in nicely with the Arc GTK theme"
HOMEPAGE="https://github.com/dglava/arc-openbox"
MY_PN="arc-openbox"
MY_PV="e6df05c592f7bef1e7a521a7f4df7c7e8424cbd1"
MY_P="${MY_PN}-${MY_PV}"
SRC_URI="https://github.com/dglava/${MY_PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

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
