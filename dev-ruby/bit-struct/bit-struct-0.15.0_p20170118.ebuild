# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit versionator

USE_RUBY="ruby21 ruby22 ruby23"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_VERSION="$(get_version_component_range 1-3)"

inherit ruby-fakegem

DESCRIPTION="Library for packed binary data stored in ruby Strings"
HOMEPAGE="https://rubygems.org/gems/bit-struct"
COMMIT="707133ae6af5420be6fbe29be6baa5fbc929da2e"
SRC_URI="https://github.com/busterb/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="Ruby-BSD"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RUBY_S="${PN}-${COMMIT}"

#no tests
RESTRICT="test"
