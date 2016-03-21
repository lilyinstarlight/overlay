# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools

DESCRIPTION="A flat theme with transparent elemnts"
HOMEPAGE="https://github.com/horst3180/arc-theme"
MY_PN="arc-theme"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://github.com/horst3180/arc-theme/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gtk2 +gtk3 +light +darker +dark +transparency cinnamon metacity unity xfwm xfce-notify gnome-shell"

DEPEND="
	x11-themes/gnome-themes-standard
	x11-themes/gtk-engines-murrine
"
RDEPEND="
	${DEPEND}
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable gtk2) \
		$(use_enable gtk3) \
		$(use_enable light) \
		$(use_enable darker) \
		$(use_enable dark) \
		$(use_enable cinnamon) \
		$(use_enable transparency) \
		$(use_enable metacity) \
		$(use_enable unity) \
		$(use_enable xfwm) \
		$(use_enable xfce-notify) \
		$(use_enable gnome-shell)
}
