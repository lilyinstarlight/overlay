# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools gnome2-utils

DESCRIPTION="Vertex icon theme"
HOMEPAGE="https://github.com/arc-theme/arc-icon-theme"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/arc-theme/${PN}"
	inherit git-r3
else
	SRC_URI="https://github.com/arc-theme/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 ~arm x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="x11-themes/moka-icon-theme"
DEPEND=""

# This ebuild does not install any binaries
RESTRICT="binchecks strip"

src_prepare() {
	default
	eautoreconf
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
