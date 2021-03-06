# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt4-r2 git-r3

DESCRIPTION="A cross-platform IRC framework written with Qt 4"
HOMEPAGE="https://github.com/communi/libcommuni"
EGIT_REPO_URI="https://github.com/communi/libcommuni"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="icu test examples"

RDEPEND="
	dev-qt/qtcore
	dev-qt/qtdeclarative
	!icu? ( dev-libs/uchardet )
	icu? ( dev-libs/icu )
"
DEPEND="
	${RDEPEND}
	test? ( dev-qt/qttest )
"

S="${WORKDIR}/${P}"

src_prepare() {
	UCHD="${S}"/src/3rdparty/uchardet-0.0.1/uchardet.pri
	echo "CONFIG *= link_pkgconfig" > "$UCHD"
	echo "PKGCONFIG += uchardet" >> "$UCHD"
	qt4-r2_src_prepare
}

src_configure() {
	eqmake4 libcommuni.pro \
		$(use examples || echo "-config no_examples") \
		$(use icu && echo "-config icu") \
		$(use test || echo "-config no_tests")
}
