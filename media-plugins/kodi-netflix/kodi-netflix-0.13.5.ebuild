# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib

DESCRIPTION="Inputstream based Netflix plugin for Kodi"
HOMEPAGE="https://github.com/asciidisco/plugin.video.netflix"

case ${PV} in
9999)
	KEYWORDS=""
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/asciidisco/plugin.video.netflix.git"
	inherit git-r3
	;;
*)
	KEYWORDS=""
	SRC_URI="https://github.com/asciidisco/plugin.video.netflix/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/plugin.video.netflix-${PV}"
	;;
esac

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="
	>=media-tv/kodi-9999
	=media-plugins/kodi-inputstream-adaptive-2*
	>=media-plugins/kodi-widevine-1.4.8.970
	<dev-python/pycparser-2.18
	dev-python/pycryptodomex[python_targets_python2_7]
"

src_compile() {
	# no-op
	true
}

src_install() {
	insinto /usr/$(get_libdir)/kodi/addons/plugin.video.netflix
	doins -r *
}
