# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="popular PCB routing and autorouting program"
HOMEPAGE="http://freerouting.net/"
MY_PN="FreeRoute"
COMMIT="a3b42bdbacc6ee72a94b7ad82cfab977b8c68ad3"
MY_P="${MY_PN}-${COMMIT}"
SRC_URI="https://github.com/sephamorr/${MY_PN}/archive/${COMMIT}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.7"
RDEPEND=">=virtual/jre-1.7"

S="${WORKDIR}/${MY_P}/${PN}"

src_install() {
	java-pkg_newjar build/FreeRouting.jar freeroute.jar
	java-pkg_dolauncher
}
