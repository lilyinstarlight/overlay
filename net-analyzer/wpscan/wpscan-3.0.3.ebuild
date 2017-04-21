# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

USE_RUBY="ruby23"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_RECIPE_TEST="rspec3"
RUBY_FAKEGEM_EXTRAINSTALL="app"

inherit ruby-fakegem

DESCRIPTION="WordPress vulnerability scanner"
HOMEPAGE="https://wpscan.org/"
MY_PN="wpscan-v3"
COMMIT="904d9507d8c6db2d921c3b502cb8acf35b85637c"
SRC_URI="https://github.com/wpscanteam/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="WPScan"

SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""

RUBY_S="${MY_PN}-${COMMIT}"

ruby_add_bdepend "dev-ruby/rspec-its >=dev-ruby/webmock-1.22.0:0"
ruby_add_rdepend "dev-ruby/yajl-ruby dev-ruby/cms_scanner dev-ruby/dm-core dev-ruby/dm-constraints dev-ruby/dm-migrations dev-ruby/dm-sqlite-adapter dev-ruby/activesupport:5.0"

all_ruby_prepare() {
	# remove unnecessary testing packages
	sed -i -e '/simplecov/ s:^:#:' spec/spec_helper.rb || die
	sed -i -e '/SimpleCov\.formatter/d' spec/spec_helper.rb || die
	sed -i -e '/SimpleCov/,/end/d' spec/spec_helper.rb || die
	sed -i -e '/simplecov/d' "${PN}".gemspec || die
	sed -i -e '/rubocop/d' "${PN}".gemspec || die
	sed -i -e '/coveralls/d' Gemfile || die

	# fix too strict versioning
	sed -i -e '/activesupport/ s/~> 5\.0\.1\.0/~> 5.0.1/' "${PN}".gemspec || die
	sed -i -e '/webmock/ s/~> 1\.22\.0/~> 1.22/' "${PN}".gemspec || die
}

each_ruby_prepare() {
	BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
	BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
}
