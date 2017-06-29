# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit npm eutils

DESCRIPTION="An interactive reference tool to help security professionals"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 -x86"
IUSE=""

NPM_EXTRA_FILES="db modules payloads bros"

DEPEND=""
RDEPEND="
		>=net-libs/nodejs-0.8.10[npm]
		${DEPEND}
"

src_install() {
	npm_src_install
	# Go to NPM source directory and run `npm install`
	pushd .;cd ${NPM_SRC_DIR};npm install ${NPM_SRC_DIR}; popd
	make_wrapper bros "${NPM_DIR}/bros"
}
