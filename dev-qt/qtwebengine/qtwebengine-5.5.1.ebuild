# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-any-r1 qt5-build

DESCRIPTION="Support library for rendering dynamic web content in Qt5 C++ and QML applications"

if [[ ${QT5_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~x86"
fi

IUSE="qml pmp"

DEPEND="
	${PYTHON_DEPS}
	>=dev-qt/qtcore-${PV}:5
	qml? ( >=dev-qt/qtdeclarative-${PV}:5 )
	>=dev-qt/qtwebchannel-${PV}:5
	>=dev-qt/qtxmlpatterns-${PV}:5
	dev-libs/nss
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXtst
"
RDEPEND="${DEPEND}"

src_prepare() {
	use pmp && epatch "${FILESDIR}"/0001-qtwebengine-Add-a-backgroundColor-property.patch
	use pmp && epatch "${FILESDIR}"/0004-qtwebengine-transparency-window-creation.patch

	qt_use_disable_mod qml quick src/src.pro
	qt_use_disable_mod qml qml src/webengine/webengine.pro

	qt5-build_src_prepare
}
