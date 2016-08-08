# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGO_PN="github.com/github/${PN}"

if [[ ${PV} == *9999 ]]; then
	inherit golang-vcs
else
	EGIT_COMMIT="v${PV}"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	inherit golang-vcs-snapshot
fi

DESCRIPTION="git extension for versioning large files"
HOMEPAGE="https://git-lfs.github.com/"

LICENSE="MIT BSD BSD-2 BSD-4 Apache-2.0"
SLOT="0"
IUSE="doc"

DEPEND="
	dev-lang/go

	doc? ( app-text/ronn )
"
RDEPEND="
	dev-vcs/git
"

S="${WORKDIR}/${P}/src/${EGO_PN}"

src_compile() {
	export GOPATH="${WORKDIR}/${P}"

	script/bootstrap

	use doc && script/man
}

src_install() {
	dobin bin/git-lfs

	use doc && doman man/*.1
}
