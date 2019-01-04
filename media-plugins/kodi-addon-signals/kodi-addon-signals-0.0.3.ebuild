# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib

DESCRIPTION="Kodi mechanism for inter-addon communication"
HOMEPAGE="https://github.com/ruuk/script.module.addon.signals"

MY_PN="script.module.addon.signals"
MY_P="${MY_PN}-${PV}"

case ${PV} in
9999)
	KEYWORDS=""
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/ruuk/${MY_PN}.git"
	inherit git-r3
	;;
*)
	COMMIT="a4e9904c3155501b616fd037bceac6fdc2539487"
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/ruuk/${MY_PN}/archive/${COMMIT}.tar.gz -> ${MY_P}.tar.gz"
	S="${WORKDIR}/${MY_PN}-${COMMIT}"
	;;
esac

LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="media-tv/kodi"

src_compile() {
	# no-op
	true
}

src_install() {
	insinto /usr/$(get_libdir)/kodi/addons/"${MY_PN}"
	doins -r *
}
