# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Libosinfo database"
HOMEPAGE="http://libosinfo.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/libosinfo/osinfo-db"
	SRC_URI=""
	KEYWORDS=""
else
    SRC_URI="https://releases.pagure.org/libosinfo/osinfo-db-${PV}.tar.xz"
	KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
fi

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	sys-apps/hwids
"
DEPEND="${RDEPEND}
    dev-util/intltool
	sys-libs/osinfo-db-tools
"
