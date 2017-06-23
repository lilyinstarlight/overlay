# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Save your code in an emergency"
HOMEPAGE="https://github.com/qw3rtman/git-fire"
COMMIT="f485fffedbc4f719c55547be22ccd0080e592c9a"
SRC_URI="https://github.com/qw3rtman/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}-${COMMIT}"

src_install() {
	dobin git-fire
}
