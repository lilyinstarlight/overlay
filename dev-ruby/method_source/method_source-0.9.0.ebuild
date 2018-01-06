# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit versionator

USE_RUBY="ruby23"

RUBY_FAKEGEM_TASK_TEST="none"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC=""

RUBY_FAKEGEM_VERSION="$(get_version_component_range 1-3)"

inherit ruby-fakegem

DESCRIPTION="Retrieve the source code for a method"
HOMEPAGE="https://github.com/banister/method_source"
SRC_URI="https://github.com/banister/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
IUSE=""
SLOT="0"

LICENSE="MIT"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"

ruby_add_bdepend "test? ( >=dev-ruby/bacon-1.1.0 )"

each_ruby_test() {
	${RUBY} -I. -S bacon -k test/test.rb || die "Tests failed."
}
