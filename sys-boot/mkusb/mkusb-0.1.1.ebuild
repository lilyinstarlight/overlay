# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="mkusb is an ISO multiboot USB tool with support for Legacy/EFI x86/amd64"
HOMEPAGE="https://github.com/fkmclane/mkusb"
SRC_URI="https://github.com/fkmclane/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	dev-util/dialog
	sys-boot/grub
	sys-fs/dosfstools
"

src_compile() {
	# no-op
	true
}

src_install() {
	newsbin "${PN}".sh "${PN}"

	doman "${PN}".1

	insinto /usr/share/"${PN}"
	doins -r examples
}
