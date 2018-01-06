# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit java-utils-2

DESCRIPTION="Java-based tools to rename TV shows, download subtitles, and validate checksums"
HOMEPAGE="https://www.filebot.net/"

MY_PN="FileBot"
SRC_URI="https://downloads.sourceforge.net/project/${PN}/${PN}/${MY_PN}_${PV}/${MY_PN}_${PV}-portable.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	|| (
		dev-java/oracle-jdk-bin:1.8[javafx]
		dev-java/oracle-jre-bin:1.8[javafx]
	)
	media-libs/chromaprint[tools]
	media-libs/fontconfig
	media-libs/libmediainfo[curl,mms]
"

S="${WORKDIR}"

src_install() {
	if use x86; then
		lib_arch="x86"
	elif use amd64; then
		lib_arch="x86_64"
	fi
	insinto /usr/share/filebot/lib
	doins "lib/${lib_arch}/libjnidispatch.so"
	doins "lib/${lib_arch}/lib7-Zip-JBinding.so"
	java-pkg_dojar "${MY_PN}.jar"
	exeopts -m755
	exeinto "/usr/bin"
	newexe "${FILESDIR}/${PN}.sh" "${PN}"
	insopts -m644
	insinto "/usr/share/pixmaps"
	doins "${FILESDIR}/${PN}.svg"
	insinto "/usr/share/applications"
	doins "${FILESDIR}/${PN}.desktop"
}
