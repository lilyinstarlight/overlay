# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_RECIPE_TEST="rspec3"
RUBY_FAKEGEM_EXTRAINSTALL="app"

inherit ruby-fakegem

DESCRIPTION="WordPress vulnerability scanner"
HOMEPAGE="https://wpscan.org/"
MY_PN="wpscan-v3"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://github.com/wpscanteam/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="WPScan"

SLOT=0
KEYWORDS="~amd64"
IUSE=""

RUBY_S="${MY_P}"

ruby_add_rdepend "dev-ruby/activesupport:5.1 dev-ruby/yajl-ruby <dev-ruby/cms_scanner-0.0.39 dev-ruby/dm-core dev-ruby/dm-constraints dev-ruby/dm-migrations dev-ruby/dm-sqlite-adapter"
ruby_add_bdepend "dev-ruby/rspec-its >=dev-ruby/webmock-1.22.0:0"

all_ruby_prepare() {
	# remove unnecessary testing packages
	sed -i -e '/simplecov/ s:^:#:' spec/spec_helper.rb || die
	sed -i -e '/SimpleCov\.formatter/d' spec/spec_helper.rb || die
	sed -i -e '/SimpleCov/,/end/d' spec/spec_helper.rb || die
	sed -i -e '/simplecov/d' "${PN}".gemspec || die
	sed -i -e '/rubocop/d' "${PN}".gemspec || die
	sed -i -e '/coveralls/d' Gemfile || die

	# fix too strict versioning
	sed -i -e '/webmock/ s/~> 1\.22\.0/~> 1.22/' "${PN}".gemspec || die
	sed -i -e '/rspec/ s/~> 3\.6\.0/~> 3.6/' "${PN}".gemspec || die
	sed -i -e '/rspec-its/ s/~> 1\.2\.0/~> 1.2/' "${PN}".gemspec || die
	sed -i -e '/dm-core/ s/~> 1\.2\.0/~> 1.2/' "${PN}".gemspec || die
	sed -i -e '/dm-migrations/ s/~> 1\.2\.0/~> 1.2/' "${PN}".gemspec || die
	sed -i -e '/dm-constraints/ s/~> 1\.2\.0/~> 1.2/' "${PN}".gemspec || die
	sed -i -e '/dm-sqlite-adapter/ s/~> 1\.2\.0/~> 1.2/' "${PN}".gemspec || die

	# build a gem file with new versioning
	$(ruby_implementation_command "${USE_RUBY}") -S gem build "${PN}".gemspec || die

	# use gemfile to get back metadata
	tar xf "${P}.gem" -O metadata.gz | gunzip >../metadata
}
