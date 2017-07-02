# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: npm.eclass
# @MAINTAINER:
# Max Harley <augeocacher@gmail.com>
# @BLURB: Eclass for NodeJS packages available through the npm registry.
# @DESCRIPTION:
# This eclass contains various functions that may be useful when dealing with
# packages from the NPM registry for NodeJS.
# Requires EAPI=5 or later.

case ${EAPI} in
    5|6) : ;;
    *)     die "npm.eclass: unsupported EAPI=${EAPI:-0}" ;;
esac

inherit multilib

# @ECLASS-VARIABLE: NPM_MODULE
# @DESCRIPTION:
# Name of the resulting NPM module.
# The default value for NPM_MODULE is ${PN}
#
# Example: NPM_MODULE="${MY_PN}"
if [[ -z $NPM_MODULE ]]; then
    NPM_MODULE="${PN}"
fi

# @ECLASS-VARIABLE: NPM_DIR
# @DESCRIPTION:
# Directory for where the packge should be installed to. This can be used for
# making wrappers or linking binaries

# @ECLASS-VARIABLE: NPM_SRC_DIR
# @DESCRIPTION:
# Directory where the source of the NPM module will be

# @ECLASS-VARIABLE: NPM_FILES
# @INTERNAL
# @DESCRIPTION:
# Files and directories that usually come in a standard NodeJS/npm module.
NPM_FILES="index.js lib package.json ${NPM_MODULE}.js"

# @ECLASS-VARIABLE: NPM_DOCS
# @DESCRIPTION:
# Document files that come in a NodeJS/npm module, outside of the usual docs
# list of README*, ChangeLog AUTHORS* etc. These are only installed if 'doc' is
# in ${USE}
# NPM_DOCS="README* LICENSE HISTORY*"

# @ECLASS-VARIABLE: NPM_EXTRA_FILES
# @DESCRIPTION:
# If additional dist files are present in the NodeJS/npm module that are not
# listed in NPM_FILES, then this is the place to put them in.
# Can be either files, or directories.
# Example: NPM_EXTRA_FILES="rigger.js modules"

# @ECLASS-VARIABLE: NPM_EXTRA_FILES
# @DESCRIPTION:

SRC_URI="http://registry.npmjs.org/${PN}/-/${P}.tgz"

# @FUNCTION: npm_src_unpack
# @DESCRIPTION:
# Default src_unpack function for NPM packages. This funtions unpacks
# the source code, then renames the 'package' dir to ${S}.
npm_src_unpack() {
    unpack "${A}"
    mv "${WORKDIR}/package" "${S}"
}

# @FUNCTION: npm_pkg_setup
# @DESCRIPTION:
# Default pkg_setup function for NPM packages. This funtions sets
# the appropriate libdir
npm_pkg_setup() {
    NPM_DIR="/usr/$(get_libdir)/node_modules/${NPM_MODULE}"
    NPM_SRC_DIR="${D}/${NPM_DIR}"
}

# @FUNCTION: npm_src_compile
# @DESCRIPTION:
# This function does nothing.
npm_src_compile() {
    true
}

# @FUNCTION: npm_src_install
# @DESCRIPTION:
# This function installs the NPM module to an appropriate location, also
# taking care of NPM_FILES, NPM_EXTRA_FILES, NPM_DOCS

npm_src_install() {
    local npm_files="${NPM_FILES} ${NPM_EXTRA_FILES}"

    mkdir -p ${NPM_SRC_DIR} || die "Could not create DEST folder"

    # Copy files to src dir.
    for f in ${npm_files}; do
        if [[ -e "${S}/$f" ]]; then
            cp -r "${S}/$f" "${NPM_SRC_DIR}"
        fi
    done

    # Run NPM install
    pushd "${NPM_SRC_DIR}"

    npm install

    popd

    # Install docs usually found in NPM packages.
    local f
    for f in README* HISTORY* ChangeLog AUTHORS NEWS TODO CHANGES \
        THANKS BUGS FAQ CREDITS CHANGELOG*; do
        if [[ -s ${f} ]]; then
            dodoc "${f}"
        fi
    done

    if has doc ${USE}; then
        local npm_docs="${NPM_DOCS}"

        for f in $npm_docs
        do
            if [[ -e "${S}/$f" ]]; then
                dodoc -r "${S}/$f"
            fi
        done
    fi
}

EXPORT_FUNCTIONS pkg_setup src_unpack src_compile src_install
