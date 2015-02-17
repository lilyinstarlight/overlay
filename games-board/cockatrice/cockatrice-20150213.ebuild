# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils games git-r3

DESCRIPTION="A cross-platform virtual tabletop for multiplayer card games"
HOMEPAGE="http://www.reddit.com/r/Cockatrice"
EGIT_REPO_URI="git://github.com/Cockatrice/Cockatrice.git"
EGIT_COMMIT="ef65434"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+client server"
REQUIRED_USE="|| ( client server )"

#With Qt5, will additionally need qtnetwork and qtxml
DEPEND="
	dev-libs/libgcrypt:0
	dev-libs/protobuf
	dev-qt/qtcore:4
	client? (
		dev-qt/qtgui:4
		dev-qt/qtmultimedia:4
		dev-qt/qtsvg:4
	)
	server? (
		dev-qt/qtsql:4
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with client CLIENT)
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
