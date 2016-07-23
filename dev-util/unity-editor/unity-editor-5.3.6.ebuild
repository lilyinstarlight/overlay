# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils unpacker versionator

DESCRIPTION="Editor for the Unity game engine"
HOMEPAGE="http://unity3d.com/"
DATE="20160720"
RELEASE="f1"
SRC_URI="http://download.unity3d.com/download_unity/linux/${PN}-$(get_version_component_range 1-3)${RELEASE}+${DATE}_amd64.deb"

LICENSE="Unity-EULA"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="android webgl"

DEPEND=""
RDEPEND="
	sys-devel/gcc[multilib]
	media-libs/alsa-lib
	x11-libs/cairo
	sys-libs/libcap
	net-print/cups
	sys-apps/dbus
	dev-libs/expat
	media-libs/fontconfig
	media-libs/freetype
	gnome-base/gconf
	x11-libs/gdk-pixbuf
	media-libs/mesa
	dev-libs/glib:2
	virtual/glu
	x11-libs/gtk+:2
	dev-libs/nspr
	dev-libs/nss
	x11-libs/pango
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	sys-libs/zlib
	media-libs/libpng:1.2
	dev-db/postgresql
	sys-apps/lsb-release
	x11-misc/xdg-utils

	android? (
		virtual/ffmpeg
		app-arch/gzip
		net-libs/nodejs
		virtual/jre:1.7
	)

	webgl? (
		virtual/jdk:1.7
	)
"

S="${WORKDIR}"

RESTRICT="mirror preserve-libs strip"
QA_PREBUILT="*"

src_install() {
	cp -a opt "${D}"/opt

	dodoc usr/share/doc/unity-editor/{changelog.gz,copyright}

	#doicon -s 48 usr/share/icons/hicolor/48x48/apps/unity-editor-icon.png
	doicon -s 256 usr/share/icons/hicolor/256x256/apps/unity-editor-icon.png

	domenu usr/share/applications/unity-editor.desktop
	domenu usr/share/applications/unity-monodevelop.desktop

	dobin "${FILESDIR}"/unity-editor
}

pkg_postinst() {
	# must have these exact permissions (i.e. cannot do go-r)
	chmod 4755 /opt/Unity/Editor/chrome-sandbox
}
