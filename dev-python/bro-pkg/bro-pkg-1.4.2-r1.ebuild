# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="The Bro Package Manager"
HOMEPAGE="https://github.com/bro/package-manager"
MY_PN="package-manager"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://github.com/bro/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	net-analyzer/bro[source]
	dev-python/git-python
	dev-python/semantic_version
	dev-python/btest
"

S="${WORKDIR}/${MY_P}"
