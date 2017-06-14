# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23"
RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="DataMapper plugin for serializing resources and collections"
HOMEPAGE="http://github.com/datamapper/dm-serializer"

LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "dev-ruby/dm-core dev-ruby/fastercsv dev-ruby/json:0 dev-ruby/multi_json"

all_ruby_prepare() {
	# fix too strict versioning
	sed -i -e '/json/ s/~> 1\.6/> 1.6/' "${PN}".gemspec || die
	sed -i -e '/json_pure/d' "${PN}".gemspec || die
	sed -i -e '/json_pure/,/Gem::Dependency/d' ../metadata || die
}
