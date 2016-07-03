TARGET = iphone:clang:9.2:9.0
ARCHS = arm64 #armv7 armv7s arm64
SHARED_CFLAGS = -fobjc-arc
SYSROOT = $(THEOS)/sdks/iPhoneOS9.2.sdk

THEOS_STAGING_DIR = ../Staging
THEOS_PACKAGE_DIR = ../Packages
THEOS_OBJ_DIR_NAME = $(_THEOS_LOCAL_DATA_DIR)/Obj

_THEOS_PLATFORM_DPKG_DEB_COMPRESSION = bzip2

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = MobileAM
MobileAM_FRAMEWORKS = Foundation UIKit CoreGraphics
MobileAM_FILES = $(wildcard MobileAM/*.m)

include $(THEOS_MAKE_PATH)/application.mk

after-install::
	install.exec "killall \"MobileAM\"" || true
