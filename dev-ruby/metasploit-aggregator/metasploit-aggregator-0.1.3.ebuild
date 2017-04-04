# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
USE_RUBY="ruby21"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRAINSTALL=""

inherit ruby-fakegem

DESCRIPTION="Proxy for Meterpreter sessions"
HOMEPAGE="https://github.com/rapid7/metasploit-aggregator"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE=""
RESTRICT=test

ruby_add_rdepend "dev-ruby/grpc
	dev-ruby/rex-arch"
