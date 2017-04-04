# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="simple clipboard manager"
HOMEPAGE="https://github.com/mrichar1/clipster"
COMMIT="dfa75b52ee3a41fff7534aca165dc0e6a24a3680"
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
