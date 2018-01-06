# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23"
RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="DataObjects API for SQLite3"
HOMEPAGE="https://github.com/datamapper/do"

LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-db/sqlite:3"

ruby_add_rdepend "dev-ruby/data_objects"

each_ruby_configure() {
	${RUBY} -Cext/do_sqlite3 extconf.rb || die
}

each_ruby_compile() {
	emake -Cext/do_sqlite3 V=1
	mv ext/do_sqlite3/do_sqlite3.so lib/do_sqlite3/ || die
}
