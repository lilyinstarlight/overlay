# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils user systemd

DESCRIPTION="Libresonic is a free and web-based media streamer."
HOMEPAGE="http://libresonic.org"
SRC_URI="https://github.com/Libresonic/libresonic/archive/v${PV}.zip -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="ffmpeg lame selinux"

RDEPEND="
	>=virtual/jre-1.8
	lame? ( media-sound/lame )
	ffmpeg? ( virtual/ffmpeg )"

DEPEND="${RDEPEND}
	>=virtual/jdk-1.8
	dev-java/maven-bin"

LIBRESONIC_HOME="/var/lib/${PN}"
USER_GROUP="libresonic"

pkg_setup() {
	enewgroup "${USER_GROUP}"
	enewuser "${USER_GROUP}" -1 -1 ${LIBRESONIC_HOME} "${USER_GROUP}"
}

src_compile() {
	mvn -Dmaven.repo.local="${S}/.m2" -P full -pl libresonic-booter -am install || die
	mvn -Dmaven.repo.local="${S}/.m2" package || die
}

src_install() {
	local dir="/usr/libexec/${PN}"

	dodoc "${S}/README.md" "${S}/libresonic-main/Getting Started.html"

	insinto ${dir}
	doins "${S}/libresonic-main/target/${PN}.war"
	doins "${S}/libresonic-booter/target/libresonic-booter-jar-with-dependencies.jar"

	exeinto ${dir}
	doexe "${S}/libresonic-booter/src/main/script/libresonic.sh"

	systemd_dounit "${FILESDIR}/libresonic.service"
	systemd_install_serviced "${FILESDIR}/libresonic.service.conf"

	newinitd "${FILESDIR}/libresonic.initd" libresonic
	newconfd "${FILESDIR}/libresonic.confd" libresonic

	make_wrapper "${PN}" "${dir}/libresonic.sh"

	if use ffmpeg; then
		dodir ${LIBRESONIC_HOME}/transcode
		dosym /usr/bin/ffmpeg "${LIBRESONIC_HOME}/transcode/ffmpeg"
	fi

	if use lame; then
		dodir "${LIBRESONIC_HOME}/transcode"
		dosym /usr/bin/lame "${LIBRESONIC_HOME}/transcode/lame"
	fi

	keepdir "${LIBRESONIC_HOME}"
	fowners -R ${USER_GROUP}:${USER_GROUP} "${LIBRESONIC_HOME}"
}
