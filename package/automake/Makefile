# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include $(ADK_TOPDIR)/rules.mk

PKG_NAME:=		automake
PKG_VERSION:=		1.15
PKG_RELEASE:=		1
PKG_HASH:=		9908c75aabd49d13661d6dcb1bc382252d22cc77bf733a2d55e87f2aa2db8636
PKG_DESCR:=		tool for automatically generating makefiles
PKG_SECTION:=		dev/tools
PKG_BUILDDEP:=		m4-host autoconf-host autoconf
HOST_BUILDDEP:=		autoconf-host
PKG_URL:=		http://www.gnu.org/software/automake/
PKG_SITES:=		$(MASTER_SITE_GNU:=automake/)
PKG_OPTS:=		noscripts

include $(ADK_TOPDIR)/mk/host.mk
include $(ADK_TOPDIR)/mk/package.mk

$(eval $(call HOST_template,AUTOMAKE,automake,$(PKG_VERSION)-$(PKG_RELEASE)))
$(eval $(call PKG_template,AUTOMAKE,automake,$(PKG_VERSION)-$(PKG_RELEASE),$(PKG_DEPENDS),$(PKG_DESCR),$(PKG_SECTION),$(PKG_OPTS)))

XAKE_FLAGS+=		PERL="/usr/bin/perl"

automake-install:
	$(INSTALL_DIR) $(IDIR_AUTOMAKE)/usr/bin
	$(INSTALL_BIN) $(WRKINST)/usr/bin/automake $(IDIR_AUTOMAKE)/usr/bin
	$(INSTALL_BIN) $(WRKINST)/usr/bin/aclocal $(IDIR_AUTOMAKE)/usr/bin
	$(INSTALL_DIR) $(IDIR_AUTOMAKE)/usr/share/aclocal-$(PKG_VERSION)
	$(CP) $(WRKINST)/usr/share/aclocal-$(PKG_VERSION) \
		$(IDIR_AUTOMAKE)/usr/share
	$(INSTALL_DIR) $(IDIR_AUTOMAKE)/usr/share/automake-$(PKG_VERSION)
	$(CP) $(WRKINST)/usr/share/automake-$(PKG_VERSION) \
		$(IDIR_AUTOMAKE)/usr/share

include $(ADK_TOPDIR)/mk/host-bottom.mk
include $(ADK_TOPDIR)/mk/pkg-bottom.mk
