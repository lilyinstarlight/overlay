# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib

DESCRIPTION="Inputstream based Netflix plugin for Kodi"
HOMEPAGE="https://github.com/asciidisco/plugin.video.netflix"

case ${PV} in
9999)
	KEYWORDS=""
	SRC_URI=""
	EGIT_REPO_URI="git://github.com/asciidisco/plugin.video.netflix.git"
	inherit git-r3
	;;
*)
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/asciidisco/plugin.video.netflix/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/plugin.video.netflix-${PV}"
	;;
esac

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="
	>=media-tv/kodi-9999[agile]
	>=media-plugins/kodi-inputstream-adaptive-9999[agile]
	>=media-plugins/kodi-widevine-1.4.8.962
	dev-python/pycryptodomex[python_targets_python2_7]
"

src_install() {
	insinto /usr/$(get_libdir)/kodi/addons/plugin.video.netflix
	doins -r *
}
