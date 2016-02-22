# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils games

DESCRIPTION="A cross-platform virtual tabletop for multiplayer card games"
HOMEPAGE="https://github.com/Cockatrice/Cockatrice"
MY_PN="Cockatrice"
MY_PV="${PV:0:4}-${PV:4:2}-${PV:6:2}-Release"
MY_P="${MY_PN}-${MY_PV}"
SRC_URI="https://github.com/Cockatrice/Cockatrice/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+client server"
REQUIRED_USE="|| ( client server )"

#With Qt5, will additionally need qtnetwork and qtxml and won't need libgcrypt
DEPEND="
	dev-libs/protobuf
	dev-qt/qtcore:4
	client? (
		dev-qt/qtgui:4
		dev-qt/qtmultimedia:4
		dev-qt/qtsvg:4
	)
	server? (
		dev-libs/libgcrypt:0
		dev-qt/qtsql:4
	)
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with client CLIENT)
		$(cmake-utils_use_with client ORACLE)
		$(cmake-utils_use_with server SERVER)
		-DWITH_QT4=ON
		-DCMAKE_INSTALL_BINDIR="${GAMES_BINDIR}"
		-DCMAKE_INSTALL_PREFIX="${GAMES_PREFIX}"
		-DICONDIR="/usr/share/icons"
		-DDESKTOPDIR="/usr/share/applications"
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	prepgamesdirs
}

pkg_postinst() {
	use client && \
		einfo "For initial installation, run 'oracle' before" && \
		einfo "'cockatrice' to download the card database."
}
