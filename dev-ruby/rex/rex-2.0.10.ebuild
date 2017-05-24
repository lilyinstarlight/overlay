# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

USE_RUBY="ruby21 ruby22 ruby23"
#RUBY_FAKEGEM_RECIPE_TEST="rspec3"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem

DESCRIPTION="Ruby classes useful for security testing and exploit development"
HOMEPAGE="https://rubygems.org/gems/rex"

LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

# doesn't seem to actually run any tests
RESTRICT=test

ruby_add_rdepend "dev-ruby/filesize dev-ruby/jsobfu:0 dev-ruby/json:* dev-ruby/metasm:1.0.2 dev-ruby/nokogiri dev-ruby/rb-readline-r7 dev-ruby/robots"
