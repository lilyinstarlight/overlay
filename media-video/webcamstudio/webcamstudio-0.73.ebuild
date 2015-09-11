# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

JAVA_PKG_IUSE="doc source"
WANT_ANT_TASKS="ant-nodeps ant-junit4"

inherit eutils fdo-mime java-pkg-2 java-ant-2

DESCRIPTION="Virtual webcam studio to broadcast over the internet"
HOMEPAGE="https://code.google.com/p/webcamstudio/"
REV="589"
SRC_URI="mirror://sourceforge/webcamstudio/${PN}_${PV}-r${REV}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="policykit +vloopback"

DEPEND="
	virtual/jdk:1.7
	dev-libs/glib:2
	dev-java/absolutelayout
	dev-java/appframework
	dev-java/commons-cli:1
	dev-java/commons-codec
	dev-java/commons-httpclient:3
	dev-java/commons-io
	dev-java/commons-lang:2.1
	>=dev-java/jna-3.4.0
	dev-java/jsr305
	dev-java/log4j
	java-virtuals/javamail
	dev-java/slf4j-api
	dev-java/swing-worker
"
RDEPEND="
	${DEPEND}
	virtual/ffmpeg
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-bad:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/gst-plugins-good:1.0
	media-libs/gst-plugins-ugly:1.0
	media-plugins/gst-plugins-ximagesrc:1.0
	media-sound/pulseaudio
	x11-apps/xwininfo
	vloopback? (
		media-video/webcamstudio-module
	)
	!policykit? (
		x11-libs/gksu
	)
"

EANT_BUILD_XML="${S}/build.xml"

java_prepare() {
	#Fix avconv/gstreamer/ffmpeg binaries absolute paths
	einfo "Fixing some binaries' paths"
	sed -i \
		-e "s?=gst-launch-1.0?=/usr/bin/gst-launch-1.0?" \
		-e "s?=avconv?=/usr/bin/avconv?" \
		-e "s?=ffmpeg?=/usr/bin/ffmpeg?" \
		src/webcamstudio/externals/linux/*.properties \
		src/webcamstudio/externals/linux/*/*.properties \
		|| die "Failed to fix binaries' paths"
	use policykit && sed -i \
		-e "s?\"gksu \"?\"pkexec \"?" \
		src/webcamstudio/components/*.java \
		|| die "Failed to fix binaries' paths"

	#CD to the proper folder here, so if upstream changes the tree structure
	#to be easier to fix it.
	cd "libraries"

	#Remove some bundled java libs and use Gentoo native ones
	einfo "Removing the unnecessary project's jar library files"
	rm -v 	AbsoluteLayout*.jar \
			AppFramework*.jar \
			commons-*.jar \
			jcl-over-slf4j-*.jar \
			jffmpeg-*.jar \
			jna*.jar \
			jsr*.jar \
			log4j-*.jar \
			mail*.jar \
			slf4j-*.jar \
			swing-*.jar \
			ffmpeg*.jar \
		|| die "Failed to remove some of the project's jar library files"

	java-pkg_jar-from absolutelayout absolutelayout.jar AbsoluteLayout-7.0.jar
	java-pkg_jar-from appframework appframework.jar AppFramework-1.03.jar
	java-pkg_jar-from commons-cli-1 commons-cli.jar commons-cli-1.2.jar
	java-pkg_jar-from commons-codec commons-codec.jar commons-codec-1.6.jar
	java-pkg_jar-from commons-httpclient-3 commons-httpclient.jar commons-httpclient-3.1.jar
	java-pkg_jar-from jna jna.jar jna-3.4.0.jar
	java-pkg_jar-from jna platform.jar jna-platform-3.4.0.jar
	java-pkg_jar-from commons-io-1,commons-lang-2.1,jsr305,log4j,sun-javamail,slf4j-api,swing-worker
}

pkg_setup() {
	java-pkg-2_pkg_setup
}

src_compile() {
	java-pkg-2_src_compile
}

src_install() {
	java-pkg_dojar dist/WebcamStudio.jar

	#Install only non-portage .jar bundled files
	java-pkg_jarinto /opt/${PN}/lib
	java-pkg_dojar libraries/jtwitter*.jar
	java-pkg_dojar libraries/netty*.jar
	java-pkg_dojar libraries/zxing*.jar
	java-pkg_dojar libraries/Catalano*.jar
	java-pkg_dojar libraries/imgscalr*.jar
	#JavaCPP stuff - TODO see if possible to use portage versions of libraries
	java-pkg_dojar libraries/javacpp*.jar
	java-pkg_dojar libraries/javacv*.jar
	#java-pkg_dojar libraries/ffmpeg*.jar #Apparently unnecessary
	java-pkg_dojar libraries/opencv*.jar

	#Prepare a launcher for the main application
	java-pkg_dolauncher ${PN} \
		--java_args "-splash:/opt/${PN}/start.gif" \
		--main webcamstudio.WebcamStudio \
		--jar WebcamStudio.jar

	newicon "debian/webcamstudio.png" webcamstudio.png
	domenu "debian/${PN}.desktop"

	use doc && java-pkg_dojavadoc dist/javadoc
	use source && java-pkg_dosrc src/*

	insinto /opt/${PN}
	doins src/webcamstudio/resources/start.gif
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
