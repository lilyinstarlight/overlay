# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby21 ruby22 ruby23"
RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="Simple authorization for Google APIs"
HOMEPAGE="https://rubygems.org/gems/googleauth"

LICENSE="Apache-2.0"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

ruby_add_rdepend "dev-ruby/faraday
	dev-ruby/jwt
	dev-ruby/logging
	dev-ruby/memoist
	dev-ruby/multi_json
	dev-ruby/os
	dev-ruby/signet"
