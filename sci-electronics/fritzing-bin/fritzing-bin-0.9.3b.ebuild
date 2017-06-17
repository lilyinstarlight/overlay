# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils xdg-utils

DESCRIPTION="Fritzing is an open-source hardware initiative that makes electronics accessible as a creative material for anyone"
HOMEPAGE="http://fritzing.org/"
MY_PN="${PN/-bin}"
MY_P="${MY_PN}-${PV}"
SRC_URI="
	amd64? ( http://fritzing.org/download/${PV}/linux-64bit/fritzing-${PV}.linux.AMD64.tar.bz2 )
	x86? ( http://fritzing.org/download/${PV}/linux-32bit/fritzing-${PV}.linux.i386.tar.bz2 )
"

LICENSE="GPL-3 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

RESTRICT="binchecks preserve-libs strip"

src_unpack() {
	if use amd64; then
		S="${S}.linux.AMD64"
	else
		S="${S}.linux.i386"
	fi

	default
}

src_prepare() {
	default

	sed -i -e 's#icons/##' fritzing.desktop || die
}

src_install() {
	mkdir -p "${D}"/opt/"${PN}" || die
	cp -a fritzing-parts help icons lib sketches translations "${D}"/opt/"${PN}" || die

	insinto /usr/share/mime/packages/
	doins 'icons/x-fritzing-fz.xml'
	doins 'icons/x-fritzing-fzz.xml'
	doins 'icons/x-fritzing-fzp.xml'
	doins 'icons/x-fritzing-fzpz.xml'
	doins 'icons/x-fritzing-fzb.xml'
	doins 'icons/x-fritzing-fzbz.xml'
	doins 'icons/x-fritzing-fzm.xml'

	doicon icons/fritzing_icon.png

	newicon --context mimetypes --size 128 icons/fz_icon128.png application-x-fritzing-fz.png
	newicon --context mimetypes --size 256 icons/fz_icon256.png application-x-fritzing-fz.png
	newicon --context mimetypes --size 128 icons/fzz_icon128.png application-x-fritzing-fzz.png
	newicon --context mimetypes --size 256 icons/fzz_icon256.png application-x-fritzing-fzz.png
	newicon --context mimetypes --size 128 icons/fzp_icon128.png application-x-fritzing-fzp.png
	newicon --context mimetypes --size 256 icons/fzp_icon256.png application-x-fritzing-fzp.png
	newicon --context mimetypes --size 128 icons/fzpz_icon128.png application-x-fritzing-fzpz.png
	newicon --context mimetypes --size 256 icons/fzpz_icon256.png application-x-fritzing-fzpz.png
	newicon --context mimetypes --size 128 icons/fzb_icon128.png application-x-fritzing-fzb.png
	newicon --context mimetypes --size 256 icons/fzb_icon256.png application-x-fritzing-fzb.png
	newicon --context mimetypes --size 128 icons/fzbz_icon128.png application-x-fritzing-fzbz.png
	newicon --context mimetypes --size 256 icons/fzbz_icon256.png application-x-fritzing-fzbz.png
	newicon --context mimetypes --size 128 icons/fzm_icon128.png application-x-fritzing-fzm.png
	newicon --context mimetypes --size 256 icons/fzm_icon256.png application-x-fritzing-fzm.png

	domenu fritzing.desktop

	make_wrapper ${MY_PN} "${EROOT}opt/${PN}/lib/Fritzing" "${EROOT}opt/${PN}" "${EROOT}opt/${PN}/lib"

	newman Fritzing.1 fritzing.1

	dodoc readme.md
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
