# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include $(ADK_TOPDIR)/rules.mk

PKG_NAME:=		zile
PKG_VERSION:=		2.4.11
PKG_RELEASE:=		1
PKG_HASH:=		1fd27bbddc61491b1fbb29a345d0d344734aa9e80cfa07b02892eedf831fa9cc
PKG_DESCR:=		tiny emacs clone
PKG_SECTION:=		app/editor
PKG_DEPENDS:=		libgc
PKG_BUILDDEP:=		libgc
PKG_URL:=		http://www.gnu.org/software/zile/
PKG_SITES:=		${MASTER_SITE_GNU:=zile/}

DISTFILES:=		${PKG_NAME}-${PKG_VERSION}.tar.gz

include $(ADK_TOPDIR)/mk/package.mk

$(eval $(call PKG_template,ZILE,zile,$(PKG_VERSION)-${PKG_RELEASE},${PKG_DEPENDS},${PKG_DESCR},${PKG_SECTION}))

AUTOTOOL_STYLE:=	autoreconf
TARGET_LDFLAGS+=	-ltinfo -lrt

zile-install:
	$(INSTALL_DIR) $(IDIR_ZILE)/usr/bin
	$(INSTALL_BIN) $(WRKINST)/usr/bin/zile \
		$(IDIR_ZILE)/usr/bin

include ${ADK_TOPDIR}/mk/pkg-bottom.mk
