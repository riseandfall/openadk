# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include ${ADK_TOPDIR}/rules.mk

PKG_NAME:=		gkrellm
PKG_VERSION:=		2.3.5
PKG_RELEASE:=		1
PKG_HASH:=		4fd7893cce76703f815f140c6d34889383c2b2a6d83470bf9486625f84da375e
PKG_DESCR:=		krell monitors server
PKG_SECTION:=		net/misc
PKG_DEPENDS:=		glib
PKG_BUILDDEP:=		glib
PKG_NEEDS:=		threads
PKG_URL:=		http://members.dslextreme.com/users/billw/gkrellm/gkrellm.html
PKG_SITES:=		http://members.dslextreme.com/users/billw/gkrellm/

DISTFILES:=		${PKG_NAME}-${PKG_VERSION}.tar.gz

WRKSRC=			${WRKDIR}/gkrellm-${PKG_VERSION}/server

include ${ADK_TOPDIR}/mk/package.mk

$(eval $(call PKG_template,GKRELLMD,gkrellmd,${PKG_VERSION}-${PKG_RELEASE},${PKG_DEPENDS},${PKG_DESCR},${PKG_SECTION}))

CONFIG_STYLE:=		manual
INSTALL_STYLE:=		manual

do-install:
	${INSTALL_DIR} ${IDIR_GKRELLMD}/usr/bin ${IDIR_GKRELLMD}/etc
	${INSTALL_BIN} ${WRKBUILD}/gkrellmd ${IDIR_GKRELLMD}/usr/bin/
	${INSTALL_DATA} ${WRKSRC}/gkrellmd.conf ${IDIR_GKRELLMD}/etc

include ${ADK_TOPDIR}/mk/pkg-bottom.mk
