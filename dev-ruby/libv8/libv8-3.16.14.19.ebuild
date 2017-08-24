# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
USE_RUBY="ruby23"
RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem flag-o-matic

DESCRIPTION="V8 JavaScript engine distribution"
HOMEPAGE="https://github.com/cowboyd/libv8"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

all_ruby_prepare() {
	# fix too strict versioning
	sed -i -e '/rake/ s/~> 10/> 10/' "${PN}".gemspec || die
	sed -i -e '/rake-compiler/ s/~> 0/> 0/' "${PN}".gemspec || die
	sed -i -e '/rspec/ s/~> 2/> 2/' "${PN}".gemspec || die
	sed -i -e '/rspec-spies/d' "${PN}".gemspec || die
}

each_ruby_compile() {
	append-cxxflags $(test-flags-CXX -fno-delete-null-pointer-checks)

	${RUBY} -Cext/libv8 extconf.rb || die
}

each_ruby_install() {
	each_fakegem_install

	ruby_fakegem_newins ext/libv8/arch.rb ext/libv8/arch.rb
	ruby_fakegem_newins ext/libv8/location.rb ext/libv8/location.rb
	ruby_fakegem_newins ext/libv8/paths.rb ext/libv8/paths.rb

	ruby_fakegem_newins ext/libv8/.location.yml ext/libv8/.location.yml

	for file in $(find vendor/v8/include -name '*.h'); do
		ruby_fakegem_newins "$file" "$file"
	done

	for file in $(find vendor/v8/out -name '*.a'); do
		ruby_fakegem_newins "$file" "$file"
	done
}
