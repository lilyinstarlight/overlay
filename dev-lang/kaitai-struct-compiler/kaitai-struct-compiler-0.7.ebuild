# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit java-pkg-2 versionator

DESCRIPTION="Compiler for the Kaitai Struct project"
HOMEPAGE="http://katai.io/"
MY_PN="${PN//-/_}"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://github.com/kaitai-io/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	|| ( virtual/jdk:1.7 virtual/jdk:1.8 )
	|| ( dev-java/sbt-bin dev-java/sbt )
"
RDEPEND="
	|| ( virtual/jre:1.7 virtual/jre:1.8 )
"

S="${WORKDIR}/${MY_P}"

src_compile() {
	sbt -no-share compilerJVM/universal:packageBin
}

src_install() {
	unzip jvm/target/universal/${P}.zip
	cd ${P}/lib

	java-pkg_newjar org.yaml.snakeyaml-1.16.jar org.yaml.snakeyaml.jar
	java-pkg_newjar org.scala-lang.scala-library-2.11.7.jar org.scala-lang.scala-library.jar
	java-pkg_newjar io.kaitai.kaitai-struct-compiler-"${PV}".jar io.kaitai.kaitai-struct-compiler.jar
	java-pkg_newjar com.lihaoyi.sourcecode_2.11-0.1.1.jar com.lihaoyi.sourcecode_2.11.jar
	java-pkg_newjar com.lihaoyi.fastparse_2.11-0.4.1.jar com.lihaoyi.fastparse_2.11.jar
	java-pkg_newjar com.lihaoyi.fastparse-utils_2.11-0.4.1.jar com.lihaoyi.fastparse-utils_2.11.jar
	java-pkg_newjar com.github.scopt.scopt_2.11-3.4.0.jar com.github.scopt.scopt_2.11.jar

	java-pkg_dolauncher ${PN} --main io.kaitai.struct.Main
}
