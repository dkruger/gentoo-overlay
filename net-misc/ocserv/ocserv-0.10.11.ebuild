# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools eutils flag-o-matic systemd user

DESCRIPTION="OpenConnect server (ocserv) is an SSL VPN server."
SRC_URI="ftp://ftp.infradead.org/pub/ocserv/${P}.tar.xz"
HOMEPAGE="http://www.infradead.org/ocserv/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="
	>=net-libs/gnutls-3.1.10"
RDEPEND="${DEPEND}"



src_configure() {
    if [[ ! -e configure ]] ; then
	   chmod a+x ./autogen.sh || ./autogen.sh || die "autogen failed"
	fi

	econf
}



src_install() {
	default
	find "${ED}/usr" -name '*.la' -delete
	# install documentation
	dodoc {AUTHORS,ChangeLog,COPYING,LICENSE,NEWS,README.md,TODO,doc/profile.xml,doc/sample.config}

	# Install some helper scripts
	keepdir /etc/ocserv /etc/ocserv/private /etc/ocserv/certs

	# Install the init script and config file
	newinitd "${FILESDIR}/${PN}.initd" ocserv
}
