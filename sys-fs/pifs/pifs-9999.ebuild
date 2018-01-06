# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

if [[ "${PV}" == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/philipl/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/philipl/${PN}/archive/v${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="The data-free filesystem"
HOMEPAGE="https://github.com/philipl/pifs"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="sys-fs/fuse"

src_prepare() {
	eautoreconf

	default
}
