# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23"
RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="Google Protocol Buffers"
HOMEPAGE="https://developers.google.com/protocol-buffers"

LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

each_ruby_configure() {
	${RUBY} -Cext/google/protobuf_c extconf.rb || die
}

each_ruby_compile() {
	emake -Cext/google/protobuf_c V=1
	mv ext/google/protobuf_c/protobuf_c$(get_modname) lib/google/ || die
}
