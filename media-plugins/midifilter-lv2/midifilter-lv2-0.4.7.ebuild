# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib

DESCRIPTION="LV2 plugins to filter MIDI events"
HOMEPAGE="https://github.com/x42/midifilter.lv2"
MY_PN="${PN/-lv2/.lv2}"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://github.com/x42/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/lv2"
RDEPEND=""

DOCS=( AUTHORS README.md )

S="${WORKDIR}/${MY_P}"

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" LIBDIR="$(get_libdir)" install

	for DOC in ${DOCS}; do
		dodoc ${DOC}
	done
}
