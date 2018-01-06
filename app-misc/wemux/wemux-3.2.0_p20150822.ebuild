# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit user

DESCRIPTION="multi-user tmux made easy"
HOMEPAGE="https://github.com/zolrath/wemux"
COMMIT="01c6541f8deceff372711241db2a13f21c4b210c"
SRC_URI="https://github.com/zolrath/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=app-misc/tmux-1.6"

S="${WORKDIR}/${PN}-${COMMIT}"

pkg_setup() {
	enewgroup wemux
}

src_prepare() {
	sed -i -e "s#/usr/local/etc#/etc#g" wemux || die
	sed -i -e "16ihost_groups=(wemux)" wemux.conf.example || die

	default
}

src_install() {
	dobin wemux

	doman man/wemux.1

	insinto /etc
	newins wemux.conf.example wemux.conf
}

pkg_postinst() {
	einfo "You should modify /etc/wemux.conf to"
	einfo "satisfy your needs before starting wemux."
}
