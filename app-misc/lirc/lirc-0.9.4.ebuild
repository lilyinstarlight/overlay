# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{3_3,3_4,3_5} )

inherit python-single-r1

DESCRIPTION="decode and send infra-red signals of many commonly used remote controls"
HOMEPAGE="http://lirc.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
IUSE_LIRC_DEVICES="all userspace alsa_usb audio audio_alsa creative_infracd devinput dsp ftdi hiddev i2cuser iguanaIR irman usb"

for device in ${IUSE_LIRC_DEVICES}; do
	IUSE="${IUSE} lirc_devices_${device}"
done

REQUIRED_USE="
	lirc_devices_all? ( lirc_devices_userspace )
	lirc_devices_userspace? ( lirc_devices_alsa_usb lirc_devices_audio lirc_devices_audio_alsa lirc_devices_creative_infracd lirc_devices_devinput lirc_devices_dsp lirc_devices_ftdi lirc_devices_hiddev lirc_devices_i2cuser lirc_devices_iguanaIR lirc_devices_irman lirc_devices_usb )

	lirc_devices_alsa_usb? ( lirc_devices_audio_alsa )

	${PYTHON_REQUIRED_USE}
"

DEPEND="
	${PYTHON_DEPS}
	dev-python/pyyaml[${PYTHON_USEDEP}]

	lirc_devices_audio? ( media-libs/portaudio )
	lirc_devices_audio_alsa? ( media-libs/alsa-lib )
	lirc_devices_ftdi? ( dev-embedded/libftdi )
	lirc_devices_iguanaIR? ( app-misc/iguanaIR )
	lirc_devices_irman? ( media-libs/libirman )
	lirc_devices_usb? ( virtual/libusb:0 )
"
RDEPEND="${DEPEND}"

pkg_setup() {
	use lirc_devices_alsa_usb && linux_chkconfig_present SND_USB_AUDIO
	use lirc_devices_creative_infracd && linux_chkconfig_present SCSI
	use lirc_devices_devinput && linux_chkconfig_present INPUT
	use lirc_devices_dsp && linux_chkconfig_present SOUND
	use lirc_devices_hiddev && linux_chkconfig_present USB_HIDDEV
	use lirc_devices_i2cuser && linux_chkconfig_present I2C

	python-single-r1_pkg_setup
}
