# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include $(ADK_TOPDIR)/rules.mk

PKG_NAME:=		libjansson
PKG_VERSION:=		2.5
PKG_RELEASE:=		1
PKG_HASH:=		dd8bbfb38ad5031ce88e066b14d3b7e9c7113243daa7f4cde1994b7fc90bb1b1
PKG_DESCR:=		json library
PKG_SECTION:=		libs/data
PKG_URL:=		http://www.digip.org/jansson/
PKG_SITES:=		http://www.digip.org/jansson/releases/
PKG_OPTS:=		dev

DISTFILES:=             jansson-${PKG_VERSION}.tar.gz
WRKDIST=		${WRKDIR}/jansson-${PKG_VERSION}

include $(ADK_TOPDIR)/mk/package.mk

$(eval $(call PKG_template,LIBJANSSON,libjansson,$(PKG_VERSION)-${PKG_RELEASE},${PKG_DEPENDS},${PKG_DESCR},${PKG_SECTION},${PKG_OPTS}))

TARGET_LDFLAGS+=	-lm

libjansson-install:
	$(INSTALL_DIR) $(IDIR_LIBJANSSON)/usr/lib
	$(CP) $(WRKINST)/usr/lib/libjansson*.so* \
		$(IDIR_LIBJANSSON)/usr/lib

include ${ADK_TOPDIR}/mk/pkg-bottom.mk
