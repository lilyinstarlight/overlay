# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_REQ_USE="sqlite"
PYTHON_COMPAT=( python2_7 )
inherit python-single-r1

DESCRIPTION="The Bro Network Security Monitor"
HOMEPAGE="https://www.bro.org"
MY_PN="bro"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://www.bro.org/downloads/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+broctl -broker curl geoip ipv6 jemalloc +python -ruby tcmalloc"

RDEPEND="!net-analyzer/bro
	app-shells/bash:0
	dev-libs/openssl:0
	net-analyzer/ipsumdump
	net-dns/bind-tools
	net-libs/libpcap
	sys-libs/zlib
	broker? ( =dev-libs/actor-framework-0.13.2* )
	broctl? ( virtual/mta )
	curl? ( net-misc/curl )
	geoip? ( dev-libs/geoip )
	ipv6? ( net-analyzer/ipsumdump[ipv6] )
	jemalloc? ( dev-libs/jemalloc )
	python? ( ${PYTHON_DEPS} )
	ruby? ( >=dev-lang/ruby-1.8:= )
	tcmalloc? ( dev-util/google-perftools )
	>=dev-lang/swig-3.0.3
	dev-lang/perl"

REQUIRED_USE="broker? ( python )
	broctl? ( python )
	python? ( ${PYTHON_REQUIRED_USE} )"

S="${WORKDIR}/${MY_P}"

src_configure() {
	# no-op
	true
}

src_compile() {
	# no-op
	true
}

src_install() {
	mkdir "${D}"/usr/src -p || die
	cp -a "${S}" "${D}"/usr/src || die
}

pkg_postinst() {
	einfo "Bro source code has been installed to: /usr/src/${MY_P}"
	einfo "Build manually from there to use Bro and bro-pkg."
}
