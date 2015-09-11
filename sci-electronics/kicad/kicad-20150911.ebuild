# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
PYTHON_COMPAT=( python2_7 )

WX_GTK_VER="3.0"

inherit bzr cmake-utils fdo-mime flag-o-matic gnome2-utils python-r1 vcs-snapshot wxwidgets

DESCRIPTION="Electronic Schematic and PCB design tools."
HOMEPAGE="http://www.kicad-pcb.org"

SRC_REVISION="b6bb87af741711062116c553b1c24b51feddedf6"
LIB_REVISION="f4614a103bd4c358d7984fe4e35c57442d08e993"
DOC_REVISION="db042de5e18037c711ca9f86242f3f6c9bf5f4c4"
SRC_URI="https://github.com/KiCad/${PN}-source-mirror/tarball/${SRC_REVISION} -> ${P}.tar.gz
	!minimal? ( https://github.com/KiCad/${PN}-library/tarball/${LIB_REVISION} -> ${P}-library.tar.gz )
	help? ( https://github.com/KiCad/${PN}-doc/tarball/${DOC_REVISION} -> ${P}-doc.tar.gz )
	i18n? ( https://github.com/KiCad/${PN}-doc/tarball/${DOC_REVISION} -> ${P}-doc.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="boost doc debug examples github help i18n minimal python webkit"

REQUIRED_USE="github? ( webkit )"

# Additional languages to install besides English
LANGS="bg ca cs de el_GR es fi fr hu it ja ko nl pl pt ru sk sl sv zh_CN"
for lang in ${LANGS}; do
	IUSE+=" linguas_${lang}"
done

CDEPEND="x11-libs/wxGTK:${WX_GTK_VER}[X,opengl,webkit?]
	python? ( dev-python/wxpython:${WX_GTK_VER}[opengl] )
	x11-libs/cairo
	media-libs/glew
	app-arch/bzip2
	dev-libs/openssl:0"
DEPEND="${CDEPEND}
	>=dev-util/cmake-2.8.12.2
	boost? ( >=dev-libs/boost-1.54[context,threads,python?] )
	!boost? ( dev-vcs/bzr )
	app-arch/xz-utils
	doc? ( app-doc/doxygen )"
RDEPEND="${CDEPEND}
	sys-libs/zlib
	sci-electronics/electronics-menu"

src_prepare() {
	# If help or i18n required link the unpacked doc dir into the main source
	if use help || use i18n; then
		ln -s "${WORKDIR}/${P}"-doc "${S}/${PN}"-doc || die "ln failed"
	fi
	# If not minimal link the unpacked libraries dir into the main source
	if ! use minimal; then
		ln -s "${WORKDIR}/${P}"-library "${S}/${PN}"-library || die "ln failed"
	fi

	if use python;then
		# dev-python/wxpython don't support python3
		sed '/set(_PYTHON3_VERSIONS 3.3 3.2 3.1 3.0)/d' -i CMakeModules/FindPythonLibs.cmake || die "sed failed"
	fi

	# Only install help, tutorials, i18n in requested languages (English is installed by default)
	if use help || use i18n; then
		# Go thorugh doc make configs and remove unused languages
		for lang in ${LANGS}; do
			if ! use linguas_${lang}; then
				sed "s| \<${lang}\>||" -i ${PN}-doc/{internat,doc/{help,tutorials}}/CMakeLists.txt || die "sed failed"
			fi
		done
		# Since help and i18n languages are in the same package disable the
		# compilation/installation of the non required parts
		if ! use help; then
			sed -e '/add_subdirectory( doc/tutorials )/d' -i ${PN}-doc/CMakeLists.txt || die "sed failed"
			sed -e '/add_subdirectory( doc/help )/d' -i ${PN}-doc/CMakeLists.txt || die "sed failed"
		fi
		if ! use i18n; then
			sed -e '/add_subdirectory( internat )/d' -i ${PN}-doc/CMakeLists.txt || die "sed failed"
		fi
	fi

	# Add important missing doc files
	sed -e 's/INSTALL.txt/AUTHORS.txt CHANGELOG.txt README.txt TODO.txt/' -i CMakeLists.txt || die "sed failed"

	# Handle optional minimal install. If minimal turned off install parts lib
	if use minimal; then
		sed -e '/add_subdirectory( template )/d' -i CMakeLists.txt || die "sed failed"
	else
		sed "/add_subdirectory( bitmaps_png )/a add_subdirectory( ${PN}-library )" -i CMakeLists.txt || die "sed failed"
		sed '/make uninstall/,/# /d' -i ${PN}-library/CMakeLists.txt || die "sed failed"
	fi

	# Add documentation and fix necessary code if requested
	if use help; then
		sed "/add_subdirectory( bitmaps_png )/a add_subdirectory( ${PN}-doc )" -i CMakeLists.txt || die "sed failed"
		sed '/make uninstall/,$d' -i ${PN}-doc/CMakeLists.txt || die "sed failed"
	fi

	# Install examples in the right place if requested
	if use examples; then
		sed -e 's:${KICAD_DATA}/demos:${KICAD_DOCS}/examples:' -i CMakeLists.txt || die "sed failed"
	else
		sed -e '/add_subdirectory( demos )/d' -i CMakeLists.txt || die "sed failed"
	fi
}

src_configure() {
	if ! use boost; then
		bzr whoami "anonymous"
	fi
	if use amd64; then
		append-cxxflags -fPIC
	fi
	need-wxwidgets unicode

	mycmakeargs="${mycmakeargs}
		-DKICAD_DOCS=/usr/share/doc/${PN}
		-DKICAD_HELP=/usr/share/doc/${PN}/help
		-DwxUSE_UNICODE=ON
		$(cmake-utils_use boost KICAD_SKIP_BOOST)
		$(cmake-utils_use github BUILD_GITHUB_PLUGIN)
		$(cmake-utils_use python KICAD_SCRIPTING)
		$(cmake-utils_use python KICAD_SCRIPTING_MODULES)
		$(cmake-utils_use python KICAD_SCRIPTING_WXPYTHON)
		$(cmake-utils_use webkit KICAD_USE_WEBKIT)"
	cmake-utils_src_configure
}

src_compile() {
	use doc && doxygen Doxyfile
}

src_install() {
	cmake-utils_src_install
	if use doc ; then
		insinto /usr/share/doc/${PN}
		doins uncrustify.cfg
		cd Documentation
		doins -r GUI_Translation_HOWTO.pdf guidelines/UIpolicies.txt doxygen/*
	fi
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update

	if use minimal ; then
		ewarn "If the schematic and/or board editors complain about missing libraries when you"
		ewarn "open old projects, you will have to take one or more of the following actions :"
		ewarn "- Install the missing libraries manually."
		ewarn "- Remove the libraries from the 'Libs and Dir' preferences."
		ewarn "- Fix the libraries' locations in the 'Libs and Dir' preferences."
		ewarn "- Emerge ${PN} without the 'minimal' USE flag."
		ewarn ""
		elog
	fi
	if use i18n ; then
		ewarn "When using language localizations make sure the locale is set in /etc/locale.gen"
		ewarn "otherwise ${PN} will complain that the language cannot be set."
		ewarn ""
	fi
	elog "You may want to emerge media-gfx/wings if you want to create 3D models of components."
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
