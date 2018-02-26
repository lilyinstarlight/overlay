# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit python-r1

DESCRIPTION="Namespace package declaration for ruamel"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Python/Namespace_packages"
SRC_URI=""

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${PYTHON_DEPS}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

MODNAME="${PN#namespace-}"
MODNAME="${MODNAME//-//}"

src_unpack() {
	mkdir -p "${S}"/"${MODNAME}" || die
	cat > "${S}"/"${MODNAME}"/__init__.py <<-EOF || die
		__import__('pkg_resources').declare_namespace(__name__)
	EOF
}

src_install() {
	python_foreach_impl python_domodule "${MODNAME%%/*}"
}
