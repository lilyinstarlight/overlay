# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools eutils multilib systemd user

DESCRIPTION="Simple relay-only local mail transport agent"
HOMEPAGE="http://untroubled.org/nullmailer/"
SRC_URI="http://untroubled.org/${PN}/archive/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="ssl"

DEPEND="
	sys-apps/groff
	ssl? ( net-libs/gnutls )
"
RDEPEND="
	virtual/logger
	virtual/shadow
	ssl? ( net-libs/gnutls )
	!mail-mta/courier
	!mail-mta/esmtp
	!mail-mta/exim
	!mail-mta/mini-qmail
	!mail-mta/msmtp
	!mail-mta/netqmail
	!mail-mta/postfix
	!mail-mta/qmail-ldap
	!mail-mta/sendmail
	!mail-mta/opensmtpd
	!mail-mta/ssmtp
"

pkg_setup() {
	enewgroup nullmail 88
	enewuser nullmail 88 -1 /var/spool/nullmailer nullmail
}

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--localstatedir=/var \
		$(use_enable ssl tls)
}

src_install () {
	emake DESTDIR="${D}" install

	dodoc AUTHORS BUGS HOWTO INSTALL NEWS README TODO

	# A small bit of sample config
	insinto /etc/nullmailer
	newins "${FILESDIR}"/remotes.sample remotes

	# This contains passwords, so should be secure
	fperms 0640 /etc/nullmailer/remotes
	fowners root:nullmail /etc/nullmailer/remotes

	# daemontools stuff
	dodir /var/service/nullmailer{,/log}

	insinto /var/service/nullmailer
	newins scripts/nullmailer.run run
	fperms 700 /var/service/nullmailer/run

	insinto /var/service/nullmailer/log
	newins scripts/nullmailer-log.run run
	fperms 700 /var/service/nullmailer/log/run

	# usability
	dosym /usr/sbin/sendmail /usr/"$(get_libdir)"/sendmail

	# permissions stuff
	keepdir /var/log/nullmailer /var/spool/nullmailer/{failed,tmp,queue}
	fperms 770 /var/log/nullmailer /var/spool/nullmailer/{failed,tmp,queue}
	fowners nullmail:nullmail /usr/sbin/nullmailer-queue /usr/bin/mailq
	fperms 4711 /usr/sbin/nullmailer-queue /usr/bin/mailq

	doinitd "${FILESDIR}/${PN}"
	systemd_dounit scripts/nullmailer.service
}

pkg_postinst() {
	if [ ! -e "${ROOT}"/var/spool/nullmailer/trigger ]; then
		mkfifo "${ROOT}"/var/spool/nullmailer/trigger
	fi
	chown nullmail:nullmail "${ROOT}"/var/log/nullmailer "${ROOT}"/var/spool/nullmailer/{failed,tmp,queue,trigger}
	chmod 770 "${ROOT}"/var/log/nullmailer "${ROOT}"/var/spool/nullmailer/{failed,tmp,queue}
	chmod 660 "${ROOT}"/var/spool/nullmailer/trigger

	if [ -z ${REPLACING_VERSIONS} ]; then
		elog "To create an initial setup, please do:"
		elog "emerge --config =${CATEGORY}/${PF}"
	fi
}

pkg_postrm() {
	if [ -e "${ROOT}"/var/spool/nullmailer/trigger ]; then
		rm "${ROOT}"/var/spool/nullmailer/trigger
	fi
}

pkg_config() {
	if [ ! -s "${ROOT}"/etc/nullmailer/me ]; then
		einfo "Setting /etc/nullmailer/me"
		/bin/hostname --fqdn > "${ROOT}"/etc/nullmailer/me
	fi
	if [ ! -s "${ROOT}"/etc/nullmailer/defaultdomain ]; then
		einfo "Setting /etc/nullmailer/defaultdomain"
		/bin/hostname --domain > "${ROOT}"/etc/nullmailer/defaultdomain
	fi
}
