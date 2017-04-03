# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A Widget Factory"
HOMEPAGE="https://github.com/valr/awf"
SRC_URI="https://github.com/valr/awf/archive/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	x11-libs/gtk+:2
	x11-libs/gtk+:3
"
RDEPEND="${DEPEND}"

src_prepare() {
	./autogen.sh

	default
}
