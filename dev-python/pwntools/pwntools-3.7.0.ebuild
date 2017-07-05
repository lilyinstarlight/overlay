# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="CTF framework and exploit development library"
HOMEPAGE="http://pwntools.com"
SRC_URI="https://github.com/Gallopsled/pwntools/archive/3.7.0.tar.gz "

LICENSE="|| ( MIT GPL BSD2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=dev-python/paramiko-1.15.2
	>=dev-python/mako-1.0.0
	>=dev-python/pyelftools-0.24
	dev-python/capstone-python
	>=dev-python/pyserial-2.7-r1
	>=dev-python/requests-2.8.1
	>=dev-python/pip-7.1.2
	>=dev-python/tox-2.4.1
	>=dev-python/pygments-2.1.1
	>=dev-python/PySocks-1.5.6
	>=dev-python/python-dateutil-2.2
	>=dev-python/packaging-15.3-r2
	>=dev-python/psutil-5.0.1
	>=dev-python/intervaltree-2.1.0
	dev-util/unicorn
	dev-util/unicorn-bindings

	ropgadget>=5.3
	pypandoc
"
RDEPEND="${DEPEND}"
