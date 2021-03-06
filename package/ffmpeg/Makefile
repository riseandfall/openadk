# This file is part of the OpenADK project. OpenADK is copyrighted
# material, please see the LICENCE file in the top-level directory.

include ${ADK_TOPDIR}/rules.mk

PKG_NAME:=		ffmpeg
PKG_VERSION:=		3.3.5
PKG_RELEASE:=		1
PKG_HASH:=		1b434cff8a327e54fd0f611420996e3419c58b795d51a5b588ace2a674f1060a
PKG_DESCR:=		record, convert and stream audio & video
PKG_SECTION:=		libs/video
PKG_NEEDS:=		threads
PKG_DEPENDS:=		libncurses
PKG_BUILDDEP:=		ncurses
PKG_URL:=		http://www.ffmpeg.org/
PKG_SITES:=		http://www.ffmpeg.org/releases/
PKG_LIBNAME:=		libffmpeg
PKG_OPTS:=		dev

PKG_SUBPKGS:=		LIBFFMPEG FFSERVER FFPROBE FFMPEG
PKGSD_FFMPEG:=		video converter
PKGSC_FFMPEG:=		mm/video
PKGSS_FFMPEG:=		libffmpeg
PKGSD_FFSERVER:=	streaming server
PKGSC_FFSERVER:=	mm/video
PKGSS_FFSERVER:=	libffmpeg
PKGSD_FFPROBE:=		simple multimedia stream analyzer
PKGSC_FFPROBE:=		mm/video
PKGSS_FFPROBE:=		libffmpeg
PKGSD_LIBFFMPEG:=	video library
PKGSC_LIBFFMPEG:=	libs/video

PKG_FLAVOURS_LIBFFMPEG:=	WITH_MP3 WITH_VP8 WITH_THEORA
PKG_FLAVOURS_LIBFFMPEG+=	WITH_XVID WITH_VORBIS WITH_X264

PKGFD_WITH_X264:=	with X264 decoding support
PKGFS_WITH_X264:=	libx264
PKGFB_WITH_X264:=	libx264
ifeq ($(ADK_PACKAGE_LIBFFMPEG_WITH_X264),y)
PKG_FDEPENDS+=		libx264
endif

PKGFD_WITH_MP3:=	with MP3 encoding support
PKGFS_WITH_MP3:=	libmp3lame
PKGFB_WITH_MP3:=	lame
ifeq ($(ADK_PACKAGE_LIBFFMPEG_WITH_MP3),y)
PKG_FDEPENDS+=		libmp3lame
endif

PKGFD_WITH_VP8:=	with VP8 encoding support
PKGFS_WITH_VP8:=	libvpx
PKGFB_WITH_VP8:=	libvpx
ifeq ($(ADK_PACKAGE_LIBFFMPEG_WITH_VP8),y)
PKG_FDEPENDS+=		libvpx
endif

PKGFD_WITH_THEORA:=	with Theora encoding support
PKGFS_WITH_THEORA:=	libtheora
PKGFB_WITH_THEORA:=	libtheora
ifeq ($(ADK_PACKAGE_LIBFFMPEG_WITH_THEORA),y)
PKG_FDEPENDS+=		libtheora
endif

PKGFD_WITH_XVID:=	with Xvid encoding support
PKGFS_WITH_XVID:=	libxvid
PKGFB_WITH_XVID:=	xvidcore
ifeq ($(ADK_PACKAGE_LIBFFMPEG_WITH_XVID),y)
PKG_FDEPENDS+=		libxvid
endif

PKGFD_WITH_VORBIS:=	with Vorbis encoding support
PKGFS_WITH_VORBIS:=	libvorbisenc
PKGFB_WITH_VORBIS:=	libvorbis
ifeq ($(ADK_PACKAGE_LIBFFMPEG_WITH_VORBIS),y)
PKG_FDEPENDS+=		libvorbisenc
endif

DISTFILES:=		${PKG_NAME}-${PKG_VERSION}.tar.bz2

include ${ADK_TOPDIR}/mk/package.mk

$(eval $(call PKG_template,LIBFFMPEG,libffmpeg,${PKG_VERSION}-${PKG_RELEASE},${PKG_FDEPENDS},${PKGSD_LIBFFMPEG},${PKGSC_LIBFFMPEG},${PKG_OPTS}))
$(eval $(call PKG_template,FFMPEG,ffmpeg,${PKG_VERSION}-${PKG_RELEASE},${PKG_DEPENDS},${PKGSD_FFMPEG},${PKGSC_FFMPEG}))
$(eval $(call PKG_template,FFSERVER,ffserver,${PKG_VERSION}-${PKG_RELEASE},${PKG_DEPENDS},${PKGSD_FFSERVER},${PKGSC_FFSERVER}))
$(eval $(call PKG_template,FFPROBE,ffprobe,${PKG_VERSION}-${PKG_RELEASE},${PKG_DEPENDS},${PKGSD_FFPROBE},${PKGSC_FFPROBE}))

ifeq ($(ADK_DEBUG),y)
TARGET_CFLAGS:=		$(subst O0,O2,$(TARGET_CFLAGS))
else
TARGET_CFLAGS:=		$(subst Os,O2,$(TARGET_CFLAGS))
endif
TARGET_CPPFLAGS+=	-D_POSIX_SOURCE -D_GNU_SOURCE

ifeq ($(ADK_TARGET_CPU_WITH_MMX),y)
CONFIGURE_CPU_OPTS+=	--enable-mmx
else
CONFIGURE_CPU_OPTS+=    --disable-mmx 
endif
ifeq ($(ADK_TARGET_CPU_WITH_MMXEXT),y)
CONFIGURE_CPU_OPTS+=	--enable-mmxext
else
CONFIGURE_CPU_OPTS+=    --disable-mmxext
endif
ifeq (${ADK_TARGET_CPU_WITH_SSE4_2},y)
CONFIGURE_CPU_OPTS+=    --enable-sse42 \
			--disable-sse4 \
			--disable-ssse3 \
			--disable-sse3 \
			--disable-sse2 \
			--disable-sse
else
CONFIGURE_CPU_OPTS+=    --disable-sse42
ifeq (${ADK_TARGET_CPU_WITH_SSE4_1},y)
CONFIGURE_CPU_OPTS+=    --enable-sse4 \
			--disable-ssse3 \
			--disable-sse3 \
			--disable-sse2 \
			--disable-sse
else
CONFIGURE_CPU_OPTS+=    --disable-sse4
ifeq (${ADK_TARGET_CPU_WITH_SSSE3},y)
CONFIGURE_CPU_OPTS+=    --enable-ssse3 \
			--disable-sse3 \
			--disable-sse2 \
			--disable-sse
else
CONFIGURE_CPU_OPTS+=    --disable-ssse3
ifeq (${ADK_TARGET_CPU_WITH_SSE3},y)
CONFIGURE_CPU_OPTS+=    --enable-sse3 \
			--disable-sse2 \
			--disable-sse
else
CONFIGURE_CPU_OPTS+=    --disable-sse3
ifeq (${ADK_TARGET_CPU_WITH_SSE2},y)
CONFIGURE_CPU_OPTS+=    --enable-sse2 \
			--disable-sse
else
CONFIGURE_CPU_OPTS+=    --disable-sse2
ifeq (${ADK_TARGET_CPU_WITH_SSE},y)
CONFIGURE_CPU_OPTS+=    --enable-sse
else
CONFIGURE_CPU_OPTS+=    --disable-sse
endif
endif
endif
endif
endif
endif
ifeq ($(ADK_TARGET_SYSTEM_RASPBERRY_PI),y)
CONFIGURE_CPU_OPTS:=	--enable-armv6
endif
ifeq ($(ADK_TARGET_CPU_MIPS_MIPS32),y)
CONFIGURE_CPU_OPTS+=	--disable-mipsdsp --disable-mipsdspr2
endif

CONFIG_STYLE:=		minimal
CONFIGURE_ARGS:=	--prefix=/usr \
			--target-os=linux \
			--arch=${ADK_TARGET_CPU_ARCH} \
			--enable-cross-compile \
			--sysroot=${STAGING_TARGET_DIR} \
			--cross-prefix=${TARGET_CROSS} \
			--cc='$(TARGET_CC)' \
			--host-cc='$(HOST_CC)' \
			--disable-bzlib \
			--disable-doc \
			--disable-debug \
			--disable-iconv \
			--disable-yasm \
			--disable-optimizations \
			--disable-stripping \
			--enable-shared \
			--enable-static \
			--enable-gpl \
			--enable-nonfree \
			--enable-swscale \
			--enable-postproc \
			${CONFIGURE_CPU_OPTS}

ifeq ($(ADK_PACKAGE_LIBFFMPEG_WITH_X264),y)
CONFIGURE_ARGS+=	--enable-libx264
endif
ifeq ($(ADK_PACKAGE_LIBFFMPEG_WITH_MP3),y)
CONFIGURE_ARGS+=	--enable-libmp3lame
endif
ifeq ($(ADK_PACKAGE_LIBFFMPEG_WITH_VP8),y)
CONFIGURE_ARGS+=	--enable-libvpx
endif
ifeq ($(ADK_PACKAGE_LIBFFMPEG_WITH_THEORA),y)
CONFIGURE_ARGS+=	--enable-libtheora
endif
ifeq ($(ADK_PACKAGE_LIBFFMPEG_WITH_XVID),y)
CONFIGURE_ARGS+=	--enable-libxvid
endif
ifeq ($(ADK_PACKAGE_LIBFFMPEG_WITH_VORBIS),y)
CONFIGURE_ARGS+=	--enable-libvorbis
endif

libffmpeg-install:
	${INSTALL_DIR} ${IDIR_LIBFFMPEG}/usr/lib
	${CP} ${WRKINST}/usr/lib/libavdevice.so* ${IDIR_LIBFFMPEG}/usr/lib
	${CP} ${WRKINST}/usr/lib/libavformat.so* ${IDIR_LIBFFMPEG}/usr/lib
	${CP} ${WRKINST}/usr/lib/libavfilter.so* ${IDIR_LIBFFMPEG}/usr/lib
	${CP} ${WRKINST}/usr/lib/libavcodec.so* ${IDIR_LIBFFMPEG}/usr/lib
	${CP} ${WRKINST}/usr/lib/libavutil.so* ${IDIR_LIBFFMPEG}/usr/lib
	${CP} ${WRKINST}/usr/lib/libpostproc.so* ${IDIR_LIBFFMPEG}/usr/lib
	${CP} ${WRKINST}/usr/lib/libswscale.so* ${IDIR_LIBFFMPEG}/usr/lib
	${CP} ${WRKINST}/usr/lib/libswresample.so* ${IDIR_LIBFFMPEG}/usr/lib

ffmpeg-install:
	${INSTALL_DIR} ${IDIR_FFMPEG}/usr/bin
	${INSTALL_BIN} ${WRKINST}/usr/bin/ffmpeg ${IDIR_FFMPEG}/usr/bin

ffserver-install:
	${INSTALL_DIR} ${IDIR_FFSERVER}/etc
	$(INSTALL_DATA) $(WRKBUILD)/doc/ffserver.conf ${IDIR_FFSERVER}/etc
	${INSTALL_DIR} ${IDIR_FFSERVER}/usr/bin
	${INSTALL_BIN} ${WRKINST}/usr/bin/ffserver ${IDIR_FFSERVER}/usr/bin

ffprobe-install:
	${INSTALL_DIR} ${IDIR_FFPROBE}/usr/bin
	${INSTALL_BIN} ${WRKINST}/usr/bin/ffprobe ${IDIR_FFPROBE}/usr/bin

include ${ADK_TOPDIR}/mk/pkg-bottom.mk
