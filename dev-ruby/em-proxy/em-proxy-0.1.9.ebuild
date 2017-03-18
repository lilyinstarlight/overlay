# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
USE_RUBY="ruby20 ruby21 ruby22 ruby23"

inherit multilib ruby-fakegem

DESCRIPTION="EventMachine Proxy DSL"
HOMEPAGE="http://github.com/igrigorik/em-proxy"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "dev-ruby/eventmachine"
