# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{3_3,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="Free, open-source, non-linear video editor to create and edit videos and movies"
HOMEPAGE="http://openshot.org/"
MY_PN="${PN}-qt"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://github.com/OpenShot/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	dev-python/PyQt5
	>=media-libs/libopenshot-0.1.0
"

S="${WORKDIR}/${MY_P}"
