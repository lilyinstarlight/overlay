# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils git-r3

DESCRIPTION="A high-quality audio editing and playback library used by libopenshot."
HOMEPAGE="http://openshot.org/"
EGIT_REPO_URI="https://github.com/OpenShot/libopenshot-audio.git"
EGIT_COMMIT="2a383d0"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	x11-libs/libX11
"
DEPEND="${RDEPEND}"
