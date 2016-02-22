# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils

DESCRIPTION="A high-quality audio editing and playback library used by libopenshot."
HOMEPAGE="http://openshot.org/"
SRC_URI="https://github.com/OpenShot/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	x11-libs/libX11
"
DEPEND="${RDEPEND}"
