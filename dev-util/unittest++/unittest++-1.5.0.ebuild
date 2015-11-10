# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils

DESCRIPTION="A lightweight unit testing framework for C++"
HOMEPAGE="http://unittest-cpp.github.io/"

MY_PN="unittest-cpp"
MY_P="${MY_PN}-${PV}"

SRC_URI="https://github.com/unittest-cpp/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_install() {
	cmake-utils_src_install

	dosym libUnitTest++.a "/usr/lib/libunittest++.a"
	dosym UnitTest++ "/usr/include/unittest++"
}
