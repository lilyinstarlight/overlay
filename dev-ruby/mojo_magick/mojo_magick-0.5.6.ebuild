# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
USE_RUBY="ruby23"
RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="Ruby stateless module interface to ImageMagick"
HOMEPAGE="https://github.com/rcode5/mojo_magick"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-gfx/imagemagick"

ruby_add_rdepend "dev-ruby/rspec-expectations:3"
