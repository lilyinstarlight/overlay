# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23"
RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="An OAuth 1.0/2.0 implementation"
HOMEPAGE="https://rubygems.org/gems/signet"

LICENSE="Apache-2.0"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

ruby_add_rdepend "dev-ruby/addressable
	dev-ruby/faraday
	dev-ruby/jwt
	dev-ruby/multi_json"
