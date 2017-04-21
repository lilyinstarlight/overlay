# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

USE_RUBY="ruby23"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_RECIPE_TEST="rspec3"
RUBY_FAKEGEM_EXTRAINSTALL="app"

inherit ruby-fakegem

DESCRIPTION="Framework to provide an easy way to implement CMS Scanners"
HOMEPAGE="https://github.com/wpscanteam/CMSScanner"
MY_PN="CMSScanner"
COMMIT="b85288992bd25f4163ee20fba01f8747778bc888"
SRC_URI="https://github.com/wpscanteam/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""

RUBY_S="${MY_PN}-${COMMIT}"

ruby_add_rdepend "dev-ruby/activesupport:5.0 dev-ruby/addressable dev-ruby/nokogiri dev-ruby/opt_parse_validator dev-ruby/public_suffix dev-ruby/ruby-progressbar dev-ruby/typhoeus:1 dev-ruby/yajl-ruby"

all_ruby_prepare() {
	# remove unnecessary testing packages
	sed -i -e '/simplecov/ s:^:#:' spec/spec_helper.rb || die
	sed -i -e '/SimpleCov\.formatter/d' spec/spec_helper.rb || die
	sed -i -e '/SimpleCov/,/end/d' spec/spec_helper.rb || die
	sed -i -e '/simplecov/d' "${PN}".gemspec || die
	sed -i -e '/rubocop/d' "${PN}".gemspec || die
	sed -i -e '/coveralls/d' Gemfile || die

	# fix too strict versioning
	sed -i -e '/nokogiri/ s/~> 1\.7\.0\.1/~> 1.7.0/' "${PN}".gemspec || die
	sed -i -e '/activesupport/ s/~> 5\.0\.1\.0/~> 5.0.1/' "${PN}".gemspec || die
	sed -i -e '/webmock/ s/~> 1\.22\.0/~> 1.22/' "${PN}".gemspec || die
}

each_ruby_prepare() {
	BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
	BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
}
