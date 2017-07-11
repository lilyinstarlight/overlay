# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGO_PN="github.com/elves/elvish"

inherit golang-build golang-vcs-snapshot

DESCRIPTION="A novel Unix shell"
HOMEPAGE="https://elvish.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

SRC_URI="https://${EGO_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

src_install() {
	dobin elvish
}
