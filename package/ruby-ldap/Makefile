# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include $(ADK_TOPDIR)/rules.mk

PKG_NAME:=		ruby-ldap
PKG_VERSION:=		0.9.8
PKG_RELEASE:=		1
PKG_HASH:=		98a77579d8a11d5fb559f1f589c27af6dc8495657a8a9ecc5bd16b71c4a7e884
PKG_DESCR:=		ruby ldap extension
PKG_SECTION:=		dev/lang
PKG_DEPENDS:=		ruby libopenldap
PKG_BUILDDEP:=		ruby openldap
PKG_URL:=		http://ruby-ldap.sourceforge.net/
PKG_SITES:=		${MASTER_SITE_SOURCEFORGE:=ruby-ldap/0.9.8/}

PKG_CFLINE_RUBY_LDAP:=	depends on ADK_BROKEN

DISTFILES:=             ${PKG_NAME}-${PKG_VERSION}.tar.bz2

include $(ADK_TOPDIR)/mk/package.mk

$(eval $(call PKG_template,RUBY_LDAP,ruby-ldap,$(PKG_VERSION)-${PKG_RELEASE},${PKG_DEPENDS},${PKG_DESCR},${PKG_SECTION}))

CONFIG_STYLE:=		manual
FAKE_FLAGS+=		DESTDIR="/"

do-configure:
	(cd $(WRKBUILD) && $(STAGING_HOST_DIR)/usr/bin/ruby -I$(STAGING_TARGET_DIR)/usr/lib/ruby/2.0.0/$(ADK_TARGET_CPU_ARCH)-linux/ extconf.rb \
		--with-openldap2 \
		--without-libnsl \
		--with-ldap-dir=$(STAGING_TARGET_DIR)/usr \
		--with-ldap-lib=$(STAGING_TARGET_DIR)/usr/lib \
		--with-ldap-include=$(STAGING_TARGET_DIR)/usr/include)

ruby-ldap-install:
	$(INSTALL_DIR) $(IDIR_RUBY_LDAP)/usr/lib/ruby/site_ruby/2.0.0/$(ADK_TARGET_CPU_ARCH)-linux
	$(INSTALL_DIR) $(IDIR_RUBY_LDAP)/usr/lib/ruby/site_ruby/2.0.0/ldap
	$(CP) $(STAGING_TARGET_DIR)/usr/lib/ruby/site_ruby/2.0.0/$(ADK_TARGET_CPU_ARCH)-linux/ldap.so \
		$(IDIR_RUBY_LDAP)/usr/lib/ruby/site_ruby/2.0.0/$(ADK_TARGET_CPU_ARCH)-linux
	$(CP) $(STAGING_TARGET_DIR)//usr/lib/ruby/site_ruby/2.0.0/ldap/*.rb \
		$(IDIR_RUBY_LDAP)/usr/lib/ruby/site_ruby/2.0.0/ldap

include ${ADK_TOPDIR}/mk/pkg-bottom.mk
