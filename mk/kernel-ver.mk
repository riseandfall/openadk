# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.
#
# On the various kernel version variables:
#
# KERNEL_FILE_VER: version numbering used for tarball and contained top level
#                  directory (e.g. linux-4.1.2.tar.bz2 -> linux-4.1.2) (not
#                  necessary equal to kernel's version, e.g. linux-3.19
#                  contains kernel version 3.19.0)
# KERNEL_RELEASE:  OpenADK internal versioning
# KERNEL_VERSION:  final kernel version how we want to identify a specific kernel

ifeq ($(ADK_TARGET_KERNEL_VERSION_GIT),y)
KERNEL_FILE_VER:=	$(ADK_TARGET_KERNEL_GIT)
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(ADK_TARGET_KERNEL_GIT_VER)-$(KERNEL_RELEASE)
endif
ifeq ($(ADK_TARGET_KERNEL_VERSION_4_11),y)
KERNEL_FILE_VER:=	4.11
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(KERNEL_FILE_VER)-$(KERNEL_RELEASE)
KERNEL_HASH:=		b67ecafd0a42b3383bf4d82f0850cbff92a7e72a215a6d02f42ddbafcf42a7d6
endif
ifeq ($(ADK_TARGET_KERNEL_VERSION_4_10),y)
KERNEL_FILE_VER:=	4.10.16
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(KERNEL_FILE_VER)-$(KERNEL_RELEASE)
KERNEL_HASH:=		dcc547c505e4b4d150c32426547e4aad070d7b4b103bfd559f1674c9fc7fe00b
endif
ifeq ($(ADK_TARGET_KERNEL_VERSION_4_9),y)
KERNEL_FILE_VER:=	4.9.28
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(KERNEL_FILE_VER)-$(KERNEL_RELEASE)
KERNEL_HASH:=		05d1f32f0d4853e4b31e1f9a834cb4d2695d026d6518f9287a4a2f3c28a4a928
endif
ifeq ($(ADK_TARGET_KERNEL_VERSION_4_6),y)
KERNEL_FILE_VER:=	4.6.2
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(KERNEL_FILE_VER)-$(KERNEL_RELEASE)
KERNEL_HASH:=		e158f3c69da87c2ec28d0f194dbe18b05e0d0b9e1142566615cea3390bab1c6a
endif
ifeq ($(ADK_TARGET_KERNEL_VERSION_4_4),y)
KERNEL_FILE_VER:=	4.4.62
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(KERNEL_FILE_VER)-$(KERNEL_RELEASE)
KERNEL_HASH:=		ce4b701e571b1053878acfebfcba400b872e5ae8cef1c26dc6d26e9793cd1dec
endif
ifeq ($(ADK_TARGET_KERNEL_VERSION_4_1),y)
KERNEL_FILE_VER:=	4.1.39
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(KERNEL_FILE_VER)-$(KERNEL_RELEASE)
KERNEL_HASH:=		a8e82c8b1580ac4f8b176c714206498adedec9591eda48b895f6c61116d58854
endif
ifeq ($(ADK_TARGET_KERNEL_VERSION_3_16),y)
KERNEL_FILE_VER:=	3.16.43
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(KERNEL_FILE_VER)-$(KERNEL_RELEASE)
KERNEL_HASH:=		93843c6a14e774327950159cade4c2c54ba105617275e4b595555ca9c34bc1e3
endif
ifeq ($(ADK_TARGET_KERNEL_VERSION_3_12),y)
KERNEL_FILE_VER:=	3.12.73
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(KERNEL_FILE_VER)-$(KERNEL_RELEASE)
KERNEL_HASH:=		d6353ce2c1dd52c732bd0fe7c116cff29607f9bd768f62a9b9aa0e2f0a02140a
endif
ifeq ($(ADK_TARGET_KERNEL_VERSION_3_10),y)
KERNEL_FILE_VER:=	3.10.105
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(KERNEL_FILE_VER)-$(KERNEL_RELEASE)
KERNEL_HASH:=		1c5bcc129cbbe2f665e8446b4c2fdbec0ec5f2b5d40495abfba13bbf66ac699c
endif
ifeq ($(ADK_TARGET_KERNEL_VERSION_3_4),y)
KERNEL_FILE_VER:=	3.4.113
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(KERNEL_FILE_VER)-$(KERNEL_RELEASE)
KERNEL_HASH:=		c474a1d630357e64ae89f374a2575fa9623e87ea1a97128c4d83f08d4e7a0b4f
endif
ifeq ($(ADK_TARGET_KERNEL_VERSION_3_2),y)
KERNEL_FILE_VER:=	3.2.88
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(KERNEL_FILE_VER)-$(KERNEL_RELEASE)
KERNEL_HASH:=		426d254322c521dcb16606d6a390b8600e4f6ccf0edd03bbffc582d6cda1429c
endif
ifeq ($(ADK_TARGET_KERNEL_VERSION_2_6_32),y)
KERNEL_FILE_VER:=	2.6.32.70
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(KERNEL_FILE_VER)-$(KERNEL_RELEASE)
KERNEL_HASH:=		d7d0ee4588711d4f85ed67b65d447b4bbbe215e600a771fb87a62524b6341c43
endif
ifeq ($(ADK_TARGET_KERNEL_VERSION_3_4_NDS32),y)
KERNEL_FILE_VER:=	3.4-nds32
KERNEL_RELEASE:=	1
KERNEL_VERSION:=	$(KERNEL_FILE_VER)-$(KERNEL_RELEASE)
KERNEL_HASH:=		d942fb778395a491a44b144c8542bafd8ef9bb5ffb6650ce94e6304a913361c9
endif
