# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
VALA_USE_DEPEND="vapigen"

inherit gnome2 udev vala

DESCRIPTION="GObject library for managing information about real and virtual OSes"
HOMEPAGE="http://libosinfo.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3 autotools
	EGIT_REPO_URI="https://gitlab.com/libosinfo/libosinfo.git"
	SRC_URI=""
	KEYWORDS=""
else
    SRC_URI="https://releases.pagure.org/libosinfo/libosinfo-${PV}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
fi

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="+introspection +vala test"

RDEPEND="
	>=dev-libs/glib-2.36.0:2
	>=dev-libs/libxslt-1.0.0:=
	dev-libs/libxml2:=
	>=net-libs/libsoup-2.42:2.4
	sys-apps/hwids
	sys-libs/osinfo-db
	introspection? ( >=dev-libs/gobject-introspection-0.9.7:= )
"
DEPEND="${RDEPEND}
	dev-libs/gobject-introspection-common
	>=dev-util/gtk-doc-am-1.10
	virtual/pkgconfig
	test? ( dev-libs/check )
	vala? ( $(vala_depend) )
"

src_prepare() {
	if [[ ${PV} = *9999* ]]; then
		eautoreconf
	fi
	gnome2_src_prepare
	use vala && vala_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--disable-static \
		$(use_enable test tests) \
		$(use_enable introspection) \
		$(use_enable vala) \
		--disable-coverage
}
