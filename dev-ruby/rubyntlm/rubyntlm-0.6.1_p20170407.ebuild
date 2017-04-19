# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit versionator

USE_RUBY="ruby21 ruby22 ruby23"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_RECIPE_TEST="rspec3"

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"

RUBY_FAKEGEM_VERSION="$(get_version_component_range 1-3)"

inherit ruby-fakegem

DESCRIPTION="Ruby/NTLM provides message creator and parser for the NTLM authentication."
HOMEPAGE="https://github.com/winrb/rubyntlm"
COMMIT="7e2daf6076ba55a435d3e345498a7df40faa3d49"
SRC_URI="https://github.com/WinRb/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RUBY_S="${PN}-${COMMIT}"

all_ruby_prepare() {
	sed -i -e '/simplecov/ s:^:#:' spec/spec_helper.rb || die
}
