# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 python3_{4,5} )

inherit distutils-r1

DESCRIPTION="Management command for creating compressed archives of Django projects, including database tables and uploaded media"
HOMEPAGE="https://django-archive.readthedocs.io/en/latest/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN/-/_}/${PN/-/_}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/django[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN/-/_}-${PV}"
