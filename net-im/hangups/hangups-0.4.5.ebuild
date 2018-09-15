# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6} )
inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/tdryer/${PN}"
	inherit git-r3
else
	SRC_URI="https://github.com/tdryer/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Third Party IM Client for Google Hangouts"
HOMEPAGE="https://pypi.python.org/pypi/hangups"

LICENSE="MIT"
SLOT="0"
IUSE="test"

PATCHES=(
	"${FILESDIR}"/unpin-dependencies.patch
)

COMMON_DEPEND=">=dev-python/configargparse-0.11.0[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-1.3.0[${PYTHON_USEDEP}]
	<dev-python/aiohttp-4
	>=dev-python/appdirs-1.4.0[${PYTHON_USEDEP}]
	<dev-python/appdirs-1.5
	>=dev-python/async_timeout-2[${PYTHON_USEDEP}]
	<dev-python/async_timeout-4
	>=dev-python/readlike-0.1.2[${PYTHON_USEDEP}]
	>=dev-python/requests-2.6.0[${PYTHON_USEDEP}]
	<dev-python/requests-3.0.0
	>=dev-python/ReParser-1.4.3[${PYTHON_USEDEP}]
	>=dev-python/protobuf-python-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/urwid-1.3.1[${PYTHON_USEDEP}]
	>=dev-python/MechanicalSoup-0.6.0[${PYTHON_USEDEP}]"
	DEPEND="${COMMON_DEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		>=dev-python/pytest-3.1.3[${PYTHON_USEDEP}]
		>=dev-python/pylint-1.7.2[${PYTHON_USEDEP}]
		>=dev-python/pycodestyle-2.2.0[${PYTHON_USEDEP}]
		>=dev-python/httpretty-0.8.14[${PYTHON_USEDEP}]
		>=dev-python/docutils-0.14[${PYTHON_USEDEP}]
	)
"
RDEPEND="${COMMON_DEPEND}"

python_test() {
	pytest hangups
}
