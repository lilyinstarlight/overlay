# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-mod

DESCRIPTION="Input driver for SPI keyboard/touchpad and touchbar in newer Macbooks"
HOMEPAGE="https://github.com/roadrunner2/macbook12-spi-driver"

COMMIT="ad039128f2419d743d14efc9ddd886115abfbda7"
SRC_URI="https://github.com/roadrunner2/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}-${COMMIT}"

MODULE_NAMES="applespi(extra:${S}) apple-ibridge(extra:${S}) apple-ib-tb(extra:${S}) apple-ib-als(extra:${S})"
BUILD_TARGETS="all"

CONFIG_CHECK="~SPI_PXA2XX ~SPI_PXA2XX_PCI ~MFD_INTEL_LPSS_PCI ~HID_SENSOR_ALS"

src_compile() {
	BUILD_PARAMS="KDIR=${KV_OUT_DIR} M=${S}"
	linux-mod_src_compile
}
