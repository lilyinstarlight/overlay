# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A set of LV2 plugins from the Guitarix project"
HOMEPAGE="http://guitarix.org/"
MY_PN="GxPlugins.lv2"

if [[ "${PV}" = "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/brummer10/${MY_PN}.git"
else
	SRC_URI="https://github.com/brummer10/${MY_PN}/releases/download/v${PV}/${MY_PN%.*}_v${PV}.zip"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_PN}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	media-libs/lv2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
