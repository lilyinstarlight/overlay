# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR="MIKEGRB"
inherit perl-module

DESCRIPTION="Perl Interface to the Linode API"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-perl/Module-Build-Tiny
	dev-perl/LWP-Protocol-https
	dev-perl/JSON
"
RDEPEND="
	${DEPEND}
"

SRC_TEST="do"
