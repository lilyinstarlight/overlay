# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE='sqlite(+)'

inherit python-single-r1 systemd versionator

DESCRIPTION="A python based web application for monitoring your Plex Media Server."
HOMEPAGE="https://tautulli.com"
MY_PV="${PV/_beta/-beta}"
MY_PN="Tautulli"
MY_P="${MY_PN}-${MY_PV}"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
"

RDEPEND="
	media-tv/plex-media-server
	dev-python/pyopenssl
	${DEPEND}
"

S="${WORKDIR}/${MY_P}"

src_install() {
	dodoc API.md CHANGELOG.md CONTRIBUTING.md ISSUE_TEMPLATE.md README.md
	insinto "/opt/${PN}"
	doins -r contrib data lib plexpy pylintrc PlexPy.py Tautulli.py || die
	dodir "/etc/${PN}"
	dosym "${EPREFIX}/opt/${PN}/config.ini" "/etc/${PN}/config.ini"
	fowners -R plex:plex "/opt/${PN}"

	systemd_dounit  "${FILESDIR}/${PN}.service"
}
