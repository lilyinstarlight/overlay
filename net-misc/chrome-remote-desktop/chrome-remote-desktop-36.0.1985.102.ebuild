# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit python-single-r1 systemd unpacker user

DESCRIPTION="Chrome Remote Desktop allows you to securely access your computer over the Internet through the Chrome browser or a Chromebook."
HOMEPAGE="https://chrome.google.com/remotedesktop"

MY_P="${PN}_${PV}"

SRC_URI="
	amd64? (
		http://dl.google.com/linux/chrome-remote-desktop/deb/pool/main/c/${PN}/${MY_P}_amd64.deb
	)
	x86? (
		http://dl.google.com/linux/chrome-remote-desktop/deb/pool/main/c/${PN}/${MY_P}_i386.deb
	)
"

LICENSE="google-chrome"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="policykit"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	dev-python/psutil[$PYTHON_USEDEP]
	x11-base/xorg-server[xvfb]
	x11-libs/libXrandr
	sys-libs/pam
	!policykit? (
		x11-libs/gksu
	)
"

S="${WORKDIR}"

QA_PREBUILT="*"

src_configure() {
	#Fixes for non-Ubuntu systems
	pushd opt/google/chrome-remote-desktop
	python_fix_shebang chrome-remote-desktop
	use policykit && sed -e '/^.*sudo_command =/ s/"gksudo .*"/"pkexec"/' -i chrome-remote-desktop
	sed	-e '/^.*command =/ s/s -- sh -c/s sh -c/' -i chrome-remote-desktop
	popd
}

src_install() {
	insinto /opt/google
	doins -r opt/google/chrome-remote-desktop

	insinto /etc/opt/chrome
	doins -r etc/opt/chrome/native-messaging-hosts

	#Chromium support
	dosym /etc/opt/chrome/native-messaging-hosts /etc/chromium/native-messaging-hosts

	dodoc usr/share/doc/chrome-remote-desktop/*

	insinto /etc/pam.d
	doins "${FILESDIR}"/pam/chrome-remote-desktop

	doinitd "${FILESDIR}"/openrc/chrome-remote-desktop
	systemd_douserunit "${FILESDIR}"/systemd/chrome-remote-desktop.service
}

pkg_postinst() {
	enewgroup chrome-remote-desktop

	einfo "To use this module, open the Chrome Remote Desktop"
	einfo "app in Chrome and select Enable Remote Connections."
	einfo
	einfo "Add each user that intends to use this to the"
	einfo "chrome-remote-desktop group."
}
