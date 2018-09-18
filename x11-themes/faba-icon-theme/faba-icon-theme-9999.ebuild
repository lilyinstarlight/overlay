# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson

DESCRIPTION="Faba is a sexy and modern icon theme with Tango influences."
HOMEPAGE="http://snwh.org/moka#faba-icon-theme"
if [[ ${PV} == 9999 ]];then
	EGIT_REPO_URI="https://github.com/snwh/faba-icon-theme.git"
	inherit git-r3
else
	SRC_URI="https://github.com/snwh/faba-icon-theme/archive/v${PV}/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~arm"
fi

LICENSE="GPL-3 CC-BY-SA-4.0"
SLOT="0"

IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
