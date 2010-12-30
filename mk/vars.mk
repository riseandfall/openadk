# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

CP=			cp -fpR
INSTALL_DIR=		install -d -m0755
INSTALL_DATA=		install -m0644
INSTALL_BIN=		install -m0755
INSTALL_SCRIPT=		install -m0755
MAKEFLAGS=		$(EXTRA_MAKEFLAGS)
BUILD_USER=		$(shell id -un)
BUILD_GROUP=		$(shell id -gn)
ifneq ($(ADK_DEBUG),)
TARGET_DEBUGGING:=	-g3 -fno-omit-frame-pointer
else
TARGET_DEBUGGING:=	-fomit-frame-pointer $(TARGET_OPTIMIZATION) 
endif
TARGET_CFLAGS:=		$(TARGET_CFLAGS_ARCH) $(TARGET_DEBUGGING) -fwrapv

BASE_DIR:=		$(TOPDIR)
DISTDIR?=		${BASE_DIR}/dl
BUILD_DIR:=		${BASE_DIR}/build_${ADK_TARGET_SYSTEM}_${CPU_ARCH}_${ADK_TARGET_LIBC}
BUILD_DIR_PFX:=		$(BASE_DIR)/build_*
STAGING_PKG_DIR:=	${BASE_DIR}/pkg_${ADK_TARGET_SYSTEM}_${ADK_TARGET_LIBC}
STAGING_PKG_DIR_PFX:=	${BASE_DIR}/pkg_*
STAGING_HOST_DIR:=	${BASE_DIR}/host_${CPU_ARCH}_${ADK_TARGET_LIBC}
STAGING_HOST_DIR_PFX:=	${BASE_DIR}/host_*
STAGING_TARGET_DIR:=	${BASE_DIR}/target_${CPU_ARCH}_${ADK_TARGET_LIBC}
STAGING_TARGET_DIR_PFX:=${BASE_DIR}/target_*
TOOLCHAIN_BUILD_DIR=	$(BASE_DIR)/toolchain_build_${CPU_ARCH}_${ADK_TARGET_LIBC}
TOOLCHAIN_BUILD_DIR_PFX=$(BASE_DIR)/toolchain_build_*
TOOLS_BUILD_DIR=	$(BASE_DIR)/tools_build
TOOLS_DIR:=		$(BASE_DIR)/bin/tools
SCRIPT_DIR:=		$(BASE_DIR)/scripts
BIN_DIR:=		$(BASE_DIR)/bin/${ADK_TARGET_SYSTEM}_${CPU_ARCH}_${ADK_TARGET_LIBC}
BIN_DIR_PFX:=		$(BASE_DIR)/bin
PACKAGE_DIR:=		$(BIN_DIR)/packages
TARGET_DIR:=		$(BASE_DIR)/root_${ADK_TARGET_SYSTEM}_${CPU_ARCH}_${ADK_TARGET_LIBC}
TARGET_DIR_PFX:=	$(BASE_DIR)/root_*
TARGET_PATH=		${SCRIPT_DIR}:${TOOLS_DIR}:${STAGING_HOST_DIR}/bin:${STAGING_TARGET_DIR}/scripts:${_PATH}
REAL_GNU_TARGET_NAME=	$(CPU_ARCH)-$(ADK_VENDOR)-linux-$(ADK_TARGET_SUFFIX)
GNU_TARGET_NAME=	$(CPU_ARCH)-$(ADK_VENDOR)-linux
TOOLCHAIN_SYSROOT:=	$(TOOLCHAIN_BUILD_DIR)/libc_dev
ifeq ($(ADK_NATIVE),y) 
TARGET_CROSS:=		
TARGET_COMPILER_PREFIX?=
else
TARGET_CROSS:=		$(STAGING_HOST_DIR)/bin/$(REAL_GNU_TARGET_NAME)-
TARGET_COMPILER_PREFIX?=${TARGET_CROSS}
endif
TARGET_CC:=		${TARGET_COMPILER_PREFIX}gcc
TARGET_CXX:=		${TARGET_COMPILER_PREFIX}g++
TARGET_LD:=		${TARGET_COMPILER_PREFIX}ld
TARGET_CPPFLAGS+=	-I${STAGING_TARGET_DIR}/usr/include
TARGET_LDFLAGS+=	-Wl,-O2
PATCH=			${BASH} $(SCRIPT_DIR)/patch.sh
SED:=			sed -i -e
LINUX_DIR:=		$(BUILD_DIR)/linux
LINUX_HEADER_DIR:=	$(STAGING_TARGET_DIR)/linux-header

TARGET_CONFIGURE_OPTS=	PATH='${TARGET_PATH}' \
			AR=$(TARGET_CROSS)ar \
			AS=$(TARGET_CROSS)as \
			LD=$(TARGET_CROSS)ld \
			NM=$(TARGET_CROSS)nm \
			RANLIB=$(TARGET_CROSS)ranlib \
			CC='$(TARGET_CC)' \
			GCC='$(TARGET_CC)' \
			CXX='$(TARGET_CXX)' \
			CROSS='$(TARGET_CROSS)'
HOST_CONFIGURE_OPTS=	CC_FOR_BUILD='${HOSTCC}' \
			BUILD_CC='${HOSTCC}' \
			CFLAGS_FOR_BUILD='${HOSTCFLAGS}' \
			CPPFLAGS_FOR_BUILD='${HOSTCPPFLAGS}' \
			LDFLAGS_FOR_BUILD='${HOSTLDFLAGS}'

PKG_SUFFIX:=		$(strip $(subst ",, $(ADK_PACKAGE_SUFFIX)))

ifeq ($(ADK_TARGET_PACKAGE_IPKG),y)
PKG_BUILD:=		PATH='${TARGET_PATH}' \
			${BASH} ${SCRIPT_DIR}/ipkg-build
PKG_INSTALL:=		IPKG_TMP=$(BUILD_DIR)/tmp \
			IPKG_INSTROOT=$(TARGET_DIR) \
			IPKG_CONF_DIR=$(STAGING_TARGET_DIR)/etc \
			IPKG_OFFLINE_ROOT=$(TARGET_DIR) \
			${BASH} ${SCRIPT_DIR}/ipkg \
			-force-defaults -force-depends install
PKG_STATE_DIR:=		$(TARGET_DIR)/usr/lib/ipkg
else
PKG_BUILD:=		${BASH} ${SCRIPT_DIR}/tarpkg build
PKG_INSTALL:=		PKG_INSTROOT=$(TARGET_DIR) \
			${BASH} ${SCRIPT_DIR}/tarpkg install
PKG_STATE_DIR:=		$(TARGET_DIR)/usr/lib/pkg
endif

ifeq ($(ADK_NATIVE),y)
RSTRIP:=		prefix=' ' ${BASH} ${SCRIPT_DIR}/rstrip.sh
else
RSTRIP:=		prefix='${TARGET_CROSS}' ${BASH} ${SCRIPT_DIR}/rstrip.sh
endif

EXTRACT_CMD=		mkdir -p ${WRKDIR}; \
			cd ${WRKDIR} && \
			for file in ${FULLDISTFILES}; do case $$file in \
			*.cpio) \
				cat $$file | $(TOPDIR)/bin/tools/cpio -i -d ;; \
			*.tar) \
				tar -xf $$file ;; \
			*.cpio.Z | *.cpio.gz | *.cgz | *.mcz) \
				gzip -dc $$file | $(TOPDIR)/bin/tools/cpio -i -d ;; \
			*.tar.Z | *.tar.gz | *.taz | *.tgz) \
				gzip -dc $$file | tar -xf - ;; \
			*.cpio.bz2 | *.cbz) \
				bzip2 -dc $$file | $(TOPDIR)/bin/tools/cpio -i -d ;; \
			*.tar.bz2 | *.tbz | *.tbz2) \
				bzip2 -dc $$file | tar -xf - ;; \
			*.zip) \
				cat $$file | $(TOPDIR)/bin/tools/cpio -ivd -H zip ;; \
			*.arm) \
				cp $$file ${WRKDIR} ;; \
			*) \
				echo "Cannot extract '$$file'" >&2; \
				false ;; \
			esac; done

ifeq ($(VERBOSE),1)
QUIET:=
else
QUIET:=			--quiet
endif
FETCH_CMD?=		wget --tries=1 --timeout=30 $(QUIET)

include $(TOPDIR)/mk/mirrors.mk
