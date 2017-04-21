# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

USE_RUBY="ruby23"
RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="Implementation of validators for the Ruby OptionParser library"
HOMEPAGE="https://github.com/wpscanteam/OptParseValidator"

LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "dev-ruby/activesupport:5.0 dev-ruby/addressable"
