# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib

DESCRIPTION="Inputstream based Netflix plugin for Kodi"
HOMEPAGE="https://github.com/asciidisco/plugin.video.netflix"

MY_PN="plugin.video.netflix"
MY_P="${MY_PN}-${PV}"

case ${PV} in
9999)
	KEYWORDS=""
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/asciidisco/plugin.video.netflix.git"
	inherit git-r3
	;;
*)
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/asciidisco/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	S="${WORKDIR}/${MY_P}"
	;;
esac

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="
	=media-tv/kodi-18*
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
