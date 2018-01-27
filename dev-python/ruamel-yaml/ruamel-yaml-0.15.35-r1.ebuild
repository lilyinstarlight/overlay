# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="YAML parser/emitter that supports roundtrip comment preservation"
HOMEPAGE="https://pypi.python.org/pypi/ruamel.yaml"
MY_PN="${PN//-/.}"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://bitbucket.org/${MY_PN/.//}/get/${PV}.tar.gz -> ${MY_P}-r1.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc libyaml test"
REQUIRED_USE="${PYTHON_REQUIRED_USE} test? ( libyaml )"
# ^ tests can't be properly unbundled from the libyaml c-extension

RDEPEND="${PYTHON_DEPS}
	libyaml? ( dev-libs/libyaml )
	$(python_gen_cond_dep 'dev-python/ruamel-ordereddict[${PYTHON_USEDEP}]' python2_7)"

DEPEND="${RDEPEND}
	dev-python/namespace-ruamel[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] dev-python/flake8[${PYTHON_USEDEP}] dev-python/ruamel-std-pathlib[${PYTHON_USEDEP}] )
	doc? ( dev-python/ryd[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}-r1"

python_configure_all() {
	use libyaml || sed -i -e 's|\(ext_modules\)|no_\1|' __init__.py || die
}

python_compile_all() {
	use doc && emake -C _doc html
}

python_install() {
	distutils-r1_python_install --single-version-externally-managed
	find "${ED}" -name '*.pth' -delete || die
}

python_install_all() {
	distutils-r1_python_install_all
	use doc && dodoc -r _doc/_build/html
}

python_test() {
	py.test -v _test/test_*.py || die
}
