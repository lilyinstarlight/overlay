# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit npm eutils

DESCRIPTION="An interactive reference tool to help security professionals"
HOMEPAGE="https://github.com/gabemarshell/Brosec"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 -x86"
IUSE=""

NPM_EXTRA_FILES="db modules payloads bros"

DEPEND=">=net-libs/nodejs-0.8.10[npm]"
RDEPEND="${DEPEND}"

src_install() {
	npm_src_install

	make_wrapper bros "${NPM_DIR}/bros"
}
