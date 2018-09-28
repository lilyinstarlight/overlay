# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-mod

DESCRIPTION="Input driver for SPI keyboard/touchpad and touchbar in newer Macbooks"
HOMEPAGE="https://github.com/roadrunner2/macbook12-spi-driver"

COMMIT="36f96c9800e6419b4c87a9d8238d52df18c9011f"
SRC_URI="https://github.com/roadrunner2/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}-${COMMIT}"

MODULE_NAMES="applespi(extra:${S}) appletb(extra:${S})"
BUILD_TARGETS="all"

src_compile(){
	BUILD_PARAMS="KDIR=${KV_OUT_DIR} M=${S}"
	linux-mod_src_compile
}
