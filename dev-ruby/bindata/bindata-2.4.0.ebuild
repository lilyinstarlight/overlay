# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

USE_RUBY="ruby21 ruby22 ruby23"
#RUBY_FAKEGEM_RECIPE_TEST="rspec3"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem

DESCRIPTION="A declarative way to read and write binary file formats"
HOMEPAGE="https://rubygems.org/gems/bindata"

LICENSE="Ruby"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""
