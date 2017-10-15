# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
USE_RUBY="ruby23"
RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="Embed the V8 JavaScript interpreter into Ruby"
HOMEPAGE="https://github.com/cowboyd/therubyracer"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "dev-ruby/ref dev-ruby/libv8"

all_ruby_prepare() {
	sed -i -e "/^group :development do/,/^end$/d" Gemfile || die
}

each_ruby_configure() {
	${RUBY} -Cext/v8 extconf.rb || die
}

each_ruby_compile() {
	emake -Cext/v8 V=1
	mv ext/v8/init.so lib/v8/ || die
}
