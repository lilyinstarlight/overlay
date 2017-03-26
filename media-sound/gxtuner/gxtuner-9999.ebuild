# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A simple guitar tuner for JACK"
HOMEPAGE="https://github.com/brummer10/gxtuner"

if [[ "${PV}" = "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/brummer10/${PN}.git"
else
	SRC_URI="https://github.com/brummer10/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="x11-libs/cairo
	sci-libs/fftw:3.0/3
	dev-libs/glib
	x11-libs/gtk+:3
	media-libs/zita-resampler
	media-sound/jack-audio-connection-kit"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
