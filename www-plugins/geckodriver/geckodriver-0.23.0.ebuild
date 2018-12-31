# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="WebDriver <-> Marionette proxy"
HOMEPAGE="https://github.com/mozilla/geckodriver"
SRC_URI="
	amd64? ( https://github.com/mozilla/geckodriver/releases/download/v0.20.1/geckodriver-v0.20.1-linux64.tar.gz )
	x86? ( https://github.com/mozilla/geckodriver/releases/download/v0.20.1/geckodriver-v0.20.1-linux32.tar.gz )
"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	www-client/firefox
"

S="${WORKDIR}"

QA_PREBUILT="*"

src_install() {
	dobin geckodriver
}
