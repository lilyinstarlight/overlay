# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A pass extension for managing one-time-password (OTP) tokens"
HOMEPAGE="https://github.com/tadfisher/pass-otp"
SRC_URI="https://github.com/tadfisher/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	app-admin/pass
	sys-auth/oath-toolkit
	media-gfx/qrencode
"

src_compile() {
	# nop
	true
}
