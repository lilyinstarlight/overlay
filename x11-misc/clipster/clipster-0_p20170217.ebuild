# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="simple clipboard manager"
HOMEPAGE="https://github.com/mrichar1/clipster"
COMMIT="2b044049552ff8cb4ce84fd9734f804a47be9aae"
SRC_URI="https://github.com/mrichar1/clipster/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	dev-lang/python:*
"

S="${WORKDIR}/${PN}-${COMMIT}"

src_install() {
	dobin clipster
}
