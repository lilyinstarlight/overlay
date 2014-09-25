# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Extremely fast /sbin/init replacement focused on small embedded GNU/Linux systems."
HOMEPAGE="http://troglobit.com/finit.html"
SRC_URI="https://github.com/troglobit/finit/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="alsa +bootmisc dbus +hwclock +initctl +resolvconf +tty urandom X"

DEPEND=""
RDEPEND="${DEPEND}"

use_plugin() {
	if [ -z "$2" ]; then
		pname="$1"
	else
		pname="$2"
	fi

	use "$1" && echo "${pname}.so"
}

src_compile() {
	emake PLUGINS="$(use_plugin alsa alsa-utils) $(use_plugin bootmisc) $(use_plugin dbus) $(use_plugin hwclock) $(use_plugin initctl) $(use_plugin resolvconf) $(use_plugin tty) $(use_plugin urandom) $(use_plugin X x11-common)"
}

src_install() {
	emake DESTDIR="${D}" install
}

pkg_postinst() {
	einfo "Neither finit nor Gentoo provides finit"
	einfo "recipes for your services and programs."
	einfo "You must to make them yourself in"
	einfo "/etc/finit.conf and /etc/finit.d/*."
	einfo
	einfo "An example /etc/finit.conf is available"
	einfo "in /usr/share/doc/finit/finit.conf."
	einfo
	einfo "The /etc/finit.d directory supports both"
	einfo "finit configuration files and executables."
}
