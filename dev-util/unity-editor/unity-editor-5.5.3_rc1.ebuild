# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils unpacker versionator

DESCRIPTION="Editor for the Unity game engine"
HOMEPAGE="http://unity3d.com/"

DOWNLOAD="a2454d41e248"

RELEASE="$(get_version_component_range 4)"
RELEASE="${RELEASE/rc/f}"
RELEASE="${RELEASE/beta/b}"

SRC_URI="http://beta.unity3d.com/download/${DOWNLOAD}/${PN}_amd64-$(get_version_component_range 1-3)x${RELEASE}Linux.deb"

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
	dev-dotnet/gtk-sharp
	dev-dotnet/gnome-sharp
	dev-lang/mono
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
	media-libs/libpng
	dev-db/postgresql
	sys-apps/lsb-release
	x11-misc/xdg-utils
	net-libs/nodejs[npm]
	sys-apps/fakeroot

	android? (
		virtual/ffmpeg
		app-arch/gzip
		dev-util/android-sdk-update-manager
		virtual/jre:1.7
	)

	webgl? (
		virtual/jdk:1.7
	)
"

S="${WORKDIR}"

RESTRICT="bindist mirror preserve-libs strip"
QA_PREBUILT="*"

src_install() {
	cp -a opt "${D}"/opt || die

	dodoc usr/share/doc/unity-editor/{changelog.gz,copyright}

	#doicon -s 48 usr/share/icons/hicolor/48x48/apps/unity-editor-icon.png
	doicon -s 256 usr/share/icons/hicolor/256x256/apps/unity-editor-icon.png

	domenu usr/share/applications/unity-editor.desktop
	domenu usr/share/applications/unity-monodevelop.desktop

	dobin "${FILESDIR}"/unity-editor
}

pkg_postinst() {
	# must have these exact permissions (i.e. cannot do go-r)
	chmod 4755 /opt/Unity/Editor/chrome-sandbox || die
}
