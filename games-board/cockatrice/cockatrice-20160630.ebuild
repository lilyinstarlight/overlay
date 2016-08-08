# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

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

DEPEND="
	dev-libs/protobuf
	dev-qt/qtcore:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	client? (
		dev-qt/qtconcurrent:5
		dev-qt/qtmultimedia:5
		dev-qt/qtsvg:5
	)
	server? (
		dev-qt/qtsql:5
		dev-qt/qtwebsockets:5
	)
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure() {
	local mycmakeargs=(
		-DWITH_CLIENT=$(usex client)
		-DWITH_ORACLE=$(usex client)
		-DWITH_SERVER=$(usex server)
		-DWITH_QT4=ON
		-DICONDIR="/usr/share/icons"
		-DDESKTOPDIR="/usr/share/applications"
	)

	cmake-utils_src_configure
}

pkg_postinst() {
	use client && \
		einfo "For initial installation, run 'oracle' before" && \
		einfo "'cockatrice' to download the card database."
}
