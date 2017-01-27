# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils git-r3 multiprocessing toolchain-funcs

DESCRIPTION="EDK II Open Source UEFI Firmware"
HOMEPAGE="http://www.tianocore.org/"

LICENSE="BSD-2"
SLOT="0"

IUSE="debug +qemu +secure-boot"

MY_PN="edk2"
EGIT_REPO_URI="https://github.com/tianocore/${MY_PN}"

KEYWORDS=""

OPENSSL_PV="1.0.2j"
OPENSSL_P="openssl-${OPENSSL_PV}"
SRC_URI="mirror://openssl/source/${OPENSSL_P}.tar.gz"

DEPEND="
	>=dev-lang/nasm-2.0.7
	sys-power/iasl
"
RDEPEND="
	qemu? ( app-emulation/qemu )
"

src_unpack() {
	git-r3_src_unpack

	default
}

src_prepare() {
	# This build system is impressively complicated, needless to say
	# it does things that get confused by PIE being enabled by default.
	# Add -nopie to a few strategic places... :)
	if gcc-specs-pie; then
		epatch "${FILESDIR}/edk2-nopie.patch"
	fi

	if use secure-boot; then
		local openssllib="${S}/CryptoPkg/Library/OpensslLib"
		mv "${WORKDIR}/${OPENSSL_P}" "${openssllib}" || die
		cd "${openssllib}/${OPENSSL_P}"
		epatch "${openssllib}/EDKII_${OPENSSL_P}.patch"
		cd "${openssllib}"
		sh -e ./Install.sh || die
		cd "${S}"
	fi

	default
}

src_configure() {
	source ./edksetup.sh || die

	TARGET_NAME=$(usex debug DEBUG RELEASE)
	TARGET_TOOLS="GCC$(gcc-version | tr -d .)"
	if [[ "${TARGET_TOOLS/GCC/}" -gt 49 ]]; then
		TARGET_TOOLS="GCC49"
	fi
	case $ARCH in
		amd64)	TARGET_ARCH=X64 ;;
		x86)	TARGET_ARCH=IA32 ;;
		*)		die "Unsupported $ARCH" ;;
	esac
}

src_compile() {
	emake ARCH=${TARGET_ARCH} -C BaseTools -j1

	./OvmfPkg/build.sh \
		-a "${TARGET_ARCH}" \
		-b "${TARGET_NAME}" \
		-t "${TARGET_TOOLS}" \
		-n $(makeopts_jobs) \
		-D SECURE_BOOT_ENABLE=$(usex secure-boot TRUE FALSE) \
		-D FD_SIZE_2MB \
		|| die "OvmfPkg/build.sh failed"
}

src_install() {
	local fv="Build/OvmfX64/${TARGET_NAME}_${TARGET_TOOLS}/FV"
	insinto /usr/share/${PN}
	doins "${fv}"/OVMF{,_CODE,_VARS}.fd
	dosym OVMF.fd /usr/share/${PN}/bios.bin

	if use qemu; then
		dosym ../${PN}/OVMF.fd /usr/share/qemu/efi-bios.bin
	fi
}
