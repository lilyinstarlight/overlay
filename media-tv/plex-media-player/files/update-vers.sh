#!/bin/sh

EBUILD="$1"

inherit() {
    :
}

echo -n "Load ebuild... "
. "${EBUILD}" &>/dev/null
echo "ok"

# WEB_CLIENT_BUILD_ID="$1"
URL="https://artifacts.plex.tv/web-client-pmp/${WEB_CLIENT_BUILD_ID}/buildid.cmake"

OUTFILE="`mktemp`"
SCRIPTFILE="`mktemp`"

if wget "${URL}" -O "${OUTFILE}" &> /dev/null; then
	# ${OUTFILE} format:
	#
	# set(TV_VERSION 3.64.1-d832f71)
	# set(TV-OLD_VERSION 3.13.3-5401c32)
	# set(DESKTOP_VERSION 3.63.1-7f07c07)
	#

	echo "Generate configuration"
	cat "${OUTFILE}" | sed -e 's,set[(],,g; s, ,=,g; s,),,g; s,TV-OLD_VERSION,TV_OLD_VERSION,g' > "${SCRIPTFILE}"

	echo "Load configuration"
	. "${SCRIPTFILE}"
	echo TV_VERSION="${TV_VERSION}"
	echo TV-OLD_VERSION="${TV_OLD_VERSION}"
	echo DESKTOP_VERSION="${DESKTOP_VERSION}"


	# WEB_CLIENT_DESKTOP_VERSION="3.61.1-6584c03"
	# WEB_CLIENT_TV_VERSION="3.62.1-fbf73e9"

	sed -i "${EBUILD}" -e 's,WEB_CLIENT_DESKTOP_VERSION=".*",WEB_CLIENT_DESKTOP_VERSION="'${DESKTOP_VERSION}'",g; s,WEB_CLIENT_TV_VERSION=".*",WEB_CLIENT_TV_VERSION="'${TV_VERSION}'",g;'
else
	echo "Error on downloading"
fi

rm -rf "${OUTFILE}"
rm -rf "${SCRIPTFILE}"
