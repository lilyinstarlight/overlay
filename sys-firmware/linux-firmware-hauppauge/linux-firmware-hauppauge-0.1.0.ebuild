# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Firmware for Hauppauge and WinTV tuners"
HOMEPAGE="http://www.hauppauge.com/site/support/linux.html"
UBUNTU_RELEASE="zesty"
SRC_URI="https://launchpad.net/~b-rad/+archive/ubuntu/kernel+mediatree+hauppauge/+files/${PN}_${PV}+${UBUNTU_RELEASE}.tar.gz"

LICENSE="Hauppauge-Firmware"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${P}+${UBUNTU_RELEASE}"

src_install() {
	insinto /lib/firmware
	doins "${S}"/install/0/*.fw
}
