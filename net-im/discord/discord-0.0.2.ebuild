# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="All-in-one voice and text chat for gamers"
HOMEPAGE="https://discordapp.com/"
SRC_URI="https://dl.discordapp.net/apps/linux/${PV}/${P}.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 -*"
IUSE=""

DEPEND=""
RDEPEND="
	media-libs/alsa-lib
	gnome-base/gconf:2
	x11-libs/libnotify
	dev-libs/nspr
	dev-libs/nss
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	dev-libs/libappindicator
"

S="${WORKDIR}"

RESTRICT="binchecks mirror preserve-libs strip"

src_install() {
	doicon Discord/discord.png
	domenu Discord/discord.desktop

	rm Discord/{discord.png,discord.desktop,postinst.sh} || die

	mkdir "${D}"/opt || die
	cp -a Discord "${D}"/opt/ || die

	make_wrapper discord /opt/Discord/Discord /opt/Discord /opt/Discord
}
