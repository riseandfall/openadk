# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include $(ADK_TOPDIR)/rules.mk

PKG_NAME:=		boringssl
PKG_VERSION:=		2b56981b6415dc3fa70432649c2f289c77707a69
PKG_RELEASE:=		1
PKG_GIT:=		hash
PKG_DESCR:=		ssl library
PKG_SECTION:=		libs/crypto
PKG_BUILDDEP:=		cmake-host
PKG_NEEDS:=		c++
PKG_URL:=		https://boringssl.googlesource.com/
PKG_SITES:=		https://boringssl.googlesource.com/boringssl.git
PKG_OPTS:=		dev

include $(ADK_TOPDIR)/mk/package.mk

$(eval $(call PKG_template,BORINGSSL,boringssl,$(PKG_VERSION)-$(PKG_RELEASE),$(PKG_DEPENDS),$(PKG_DESCR),$(PKG_SECTION),$(PKG_OPTS)))

WRKBUILD=               $(WRKDIR)/$(PKG_NAME)-obj
CONFIG_STYLE:=          cmake
CMAKE_FLAGS+=		-DBUILD_SHARED_LIBS=1
INSTALL_STYLE:=		manual

boringssl-install:
	$(INSTALL_DIR) $(IDIR_BORINGSSL)/usr/lib
	$(CP) $(WRKBUILD)/ssl/libssl.so \
		$(IDIR_BORINGSSL)/usr/lib

include $(ADK_TOPDIR)/mk/pkg-bottom.mk
