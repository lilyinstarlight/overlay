# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1 vcs-snapshot versionator

DESCRIPTION="Helper library for the Twilio API"
HOMEPAGE="https://github.com/twilio/twilio-python http://www.twilio.com/docs/python/install"
SRC_URI="https://github.com/twilio/${PN}-python/archive/$(get_version_component_range 1-3)$(get_version_component_range 4).tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="test"

CDEPEND="dev-python/six[${PYTHON_USEDEP}]
		dev-python/httplib2[${PYTHON_USEDEP}]
		dev-python/PySocks[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]"

RDEPEND="${CDEPEND}"
DEPEND="test? (
			${CDEPEND}
			dev-python/nose[${PYTHON_USEDEP}]
			dev-python/sphinx[${PYTHON_USEDEP}]
			dev-python/mock[${PYTHON_USEDEP}]
			dev-python/coverage[${PYTHON_USEDEP}]
			dev-python/nosexcover[${PYTHON_USEDEP}]
			dev-python/flake8[${PYTHON_USEDEP}]
			dev-python/mccabe[${PYTHON_USEDEP}]
			dev-python/wheel[${PYTHON_USEDEP}]
		)"

PATCHES=( "${FILESDIR}/no-tests.patch" )

python_test() {
	nosetests tests || die "Tests fail with ${EPYTHON}"
}
