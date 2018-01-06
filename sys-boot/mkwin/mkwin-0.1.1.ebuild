# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="mkwin is a tool for creating a bootable USB from a Windows ISO"
HOMEPAGE="https://github.com/fkmclane/mkwin"
SRC_URI="https://github.com/fkmclane/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	app-arch/p7zip
	dev-util/dialog
	sys-boot/grub
	sys-fs/dosfstools
	sys-fs/ntfs3g
"

src_compile() {
	# no-op
	true
}

src_install() {
	newsbin "${PN}".sh "${PN}"

	doman "${PN}".1
}
