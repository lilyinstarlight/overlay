# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils gnome2-utils unpacker

DESCRIPTION="Connect wirelessly to a screen using Airtame"
HOMEPAGE="https://airtame.com/download"
MY_PN="${PN/-bin/}"
MY_PN="${MY_PN}-application"
SRC_URI="
	x86? ( http://downloads-cdn.airtame.com/application/ga/lin_x86/releases/deb/airtame-application-2.4.2_i386.deb )
	amd64? ( http://downloads-cdn.airtame.com/application/ga/lin_x64/releases/deb/airtame-application-2.4.2_amd64.deb )
"

LICENSE="Airtame-EULA"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/atk
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	gnome-base/gconf:2
	media-libs/alsa-lib
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	net-print/cups
	sys-apps/dbus
	sys-libs/libcxx
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	x11-libs/libX11
	x11-libs/libXScrnSaver
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/pango
"

S="${WORKDIR}"

RESTRICT="mirror bindist"

QA_PREBUILT="
	opt/airtame-application/airtame-application
	opt/airtame-application/libnode.so
	opt/airtame-application/libffmpeg.so
	opt/airtame-application/resources/app.asar.unpacked/streamer/vendor/airtame-core/lib/libavutil.so.52.48.100
	opt/airtame-application/resources/app.asar.unpacked/streamer/vendor/airtame-core/lib/libswscale.so.2.5.101
	opt/airtame-application/resources/app.asar.unpacked/streamer/vendor/airtame-core/lib/libavcodec.so.55.39.100
	opt/airtame-application/resources/app.asar.unpacked/streamer/vendor/airtame-core/lib/airtame-modules/libaudio_encode_decode_opus.so
	opt/airtame-application/resources/app.asar.unpacked/streamer/vendor/airtame-core/lib/airtame-modules/libvideo_encode_x264.so
	opt/airtame-application/resources/app.asar.unpacked/streamer/vendor/airtame-core/lib/airtame-modules/libvideo_capture_x11.so
	opt/airtame-application/resources/app.asar.unpacked/streamer/vendor/airtame-core/lib/airtame-modules/libaudio_capture_rtaudio.so
	opt/airtame-application/resources/app.asar.unpacked/streamer/vendor/airtame-core/lib/libairtame-core.so
	opt/airtame-application/resources/app.asar.unpacked/streamer/vendor/airtame-core/lib/libairtame-crash.so
	opt/airtame-application/resources/app.asar.unpacked/streamer/vendor/airtame-core/lib/libopus.so.0.5.0
	opt/airtame-application/resources/app.asar.unpacked/streamer/vendor/airtame-core/lib/libx264.so.146
	opt/airtame-application/resources/app.asar.unpacked/streamer/vendor/airtame-core/lib/libenet.a
	opt/airtame-application/resources/app.asar.unpacked/streamer/vendor/airtame-core/lib/libairtame-core-cpp.so
	opt/airtame-application/resources/app.asar.unpacked/streamer/vendor/airtame-core/lib/libcurl.so.4.3.0
	opt/airtame-application/resources/app.asar.unpacked/streamer/vendor/airtamestreamer.node
	opt/airtame-application/resources/app.asar.unpacked/discovery/vendor/airtamediscovery.node
"

src_unpack() {
	unpack_deb ${A}
}

src_prepare() {
	sed -i \
		-e "s:/opt/airtame-application/launch-airtame.sh:airtame:g" \
		usr/share/applications/"${MY_PN}".desktop || die

	sed -i \
		-e "s:/opt/airtame-application/icon.png:airtame:g" \
		usr/share/applications/"${MY_PN}".desktop || die

	default
}

src_install() {
	insinto /opt
	doins -r opt/"${MY_PN}"

	fperms +x /opt/"${MY_PN}/${MY_PN}"

	doicon opt/"${MY_PN}"/icon.png
	domenu usr/share/applications/airtame-application.desktop

	make_wrapper airtame-application /opt/"${MY_PN}/${MY_PN}" /opt/"${MY_PN}" /opt/"${MY_PN}"/resources/app.asar.unpacked/streamer/vendor/airtame-core/lib
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
