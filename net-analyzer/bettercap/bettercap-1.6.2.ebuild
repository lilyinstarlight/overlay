# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23"
RUBY_FAKEGEM_RECIPE_DOC=""
RUBY_FAKEGEM_RECIPE_TEST=""

inherit multilib ruby-fakegem

DESCRIPTION="A complete, modular, portable and easily extensible MITM framework"
HOMEPAGE="https://github.com/evilsocket/bettercap/"
SRC_URI="https://github.com/evilsocket/bettercap/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT=0
KEYWORDS="~amd64"

IUSE="doc"

ruby_add_bdepend "
	dev-ruby/bundler
	doc? ( dev-python/sphinx )
"

ruby_add_rdepend "
	=dev-ruby/colorize-0.8*
	dev-ruby/packetfu:1.1.13
	dev-ruby/pcaprub:0.12
	dev-ruby/network_interface
	=dev-ruby/net-dns-0.8*
	=dev-ruby/rubydns-1.0*
	=dev-ruby/em-proxy-0.1*
"

each_ruby_prepare() {
	BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
	BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
}

all_fakegem_compile() {
	use doc && emake -C docs html
}

all_fakegem_install() {
	use doc && dodoc -r docs/_build/html/.
}
