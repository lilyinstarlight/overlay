# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="Tensors and dynamic neural networks in Python with strong GPU acceleration"
HOMEPAGE="http://pytorch.org/"
SRC_URI="https://github.com/pytorch/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cuda"

DEPEND="
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/cffi[${PYTHON_USEDEP}]
	dev-util/cmake
	virtual/blas
	cuda? ( dev-util/nvidia-cuda-toolkit )
"
RDEPEND="${DEPEND}"

src_compile() {
	use cuda || export NO_CUDA=1

	distutils-r1_src_compile
}
