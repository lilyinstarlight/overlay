# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="command line tool to share your UNIX terminal"
HOMEPAGE="https://www.teleconsole.com/"
SRC_URI="https://github.com/gravitational/teleconsole/releases/download/0.3.1/teleconsole-v0.3.1-linux-amd64.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"

src_install() {
	dobin teleconsole
}
