# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit gnome2

DESCRIPTION="Libosinfo database tools"
HOMEPAGE="http://libosinfo.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3 autotools
	EGIT_REPO_URI="https://gitlab.com/libosinfo/osinfo-db-tools"
	SRC_URI=""
	KEYWORDS=""
else
    SRC_URI="https://releases.pagure.org/libosinfo/osinfo-db-tools-${PV}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
fi

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.36.0:2
	dev-libs/libxml2:=
	>=app-arch/libarchive-3.0.0
	sys-devel/gettext
"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-libs/libxslt
"

src_prepare() {
	if [[ ${PV} = *9999* ]]; then
		eautoreconf
	fi
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure
}
