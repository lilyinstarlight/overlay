# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A C++ library for resampling audio signals"
HOMEPAGE="http://kokkinizita.linuxaudio.org/linuxaudio/zita-resampler/resampler.html"
SRC_URI="http://kokkinizita.linuxaudio.org/linuxaudio/downloads/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="tools"

DEPEND="
	tools? ( media-libs/libsndfile )
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/makefile-solinks.patch" )

src_prepare() {
	default

	sed -i -e "/ldconfig/d" libs/Makefile || die
}

src_compile() {
	pushd libs
	emake
	popd

	if use tools; then
		pushd apps
		emake
		popd
	fi
}

src_install() {
	pushd libs
	emake DESTDIR="${D}" PREFIX=/usr install
	popd

	if use tools; then
		pushd apps
		emake DESTDIR="${D}" PREFIX=/usr install
		popd
	fi
}
