# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

if [[ "${PV}" == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/yarrick/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/yarrick/${PN}/archive/v${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="'True' cloud storage"
HOMEPAGE="https://github.com/yarrick/pingfs"

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND="sys-fs/fuse"

src_install() {
	dodoc README
	dobin pingfs
}
