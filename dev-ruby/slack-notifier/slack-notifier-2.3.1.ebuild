# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit ruby-fakegem

DESCRIPTION="A simple Ruby wrapper for posting to Slack channels"
HOMEPAGE="https://github.com/stevenosloan/slack-notifier"

LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""
