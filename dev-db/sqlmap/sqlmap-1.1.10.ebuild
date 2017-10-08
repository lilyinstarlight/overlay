# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit eutils python-single-r1

DESCRIPTION="Automatic SQL injection and database takeover tool "
HOMEPAGE="http://sqlmap.org"
SRC_URI="https://github.com/sqlmapproject/sqlmap/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ntlm"

DEPEND=""
RDEPEND="ntlm? ( dev-python/python-ntlm[${PYTHON_USEDEP}] )"

QA_PREBUILT="
	usr/share/${PN}/udf/mysql/linux/32/lib_mysqludf_sys.so
	usr/share/${PN}/udf/mysql/linux/64/lib_mysqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/32/8.2/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/32/8.3/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/32/8.4/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/32/9.0/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/32/9.1/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/64/8.2/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/64/8.3/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/64/8.4/lib_postgresqludf_sys.so
	usr/share/${PN}/udf/postgresql/linux/64/9.0/lib_postgresqludf_sys.so"

src_install () {
	dodoc -r doc/*

	dodir /usr/share/"${PN}"

	cp -R extra lib plugins procs shell tamper thirdparty txt udf waf xml sqlmap.conf sqlmap.py sqlmapapi.py "${D}"/usr/share/"${PN}"/ || die

	python_fix_shebang "${D}"/usr/share/"${PN}"

	make_wrapper "${PN}" /usr/share/"${PN}"/sqlmap.py /usr/share/"${PN}"
}
