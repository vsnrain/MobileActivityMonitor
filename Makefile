TARGET = iphone:clang:9.2:9.0
ARCHS = arm64 #armv7 armv7s arm64
SYSROOT = $(THEOS)/sdks/iPhoneOS9.2.sdk

GO_EASY_ON_ME = 1
ADDITIONAL_OBJCFLAGS = -fobjc-arc -DTHEOS

THEOS_LAYOUT_DIR = Layout
THEOS_STAGING_DIR = Staging
THEOS_PACKAGE_DIR = Packages
THEOS_OBJ_DIR_NAME = $(_THEOS_LOCAL_DATA_DIR)/Obj

_THEOS_PLATFORM_DPKG_DEB_COMPRESSION = bzip2

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = MobileActivityMonitor
MobileActivityMonitor_FRAMEWORKS = Foundation UIKit CoreGraphics

MobileActivityMonitor_FILES = $(wildcard MobileAM/*.m)

MobileActivityMonitor_RESOURCE_DIRS = MobileAM/Resources
MobileActivityMonitor_RESOURCE_FILES = MobileAM/Info.plist
MobileActivityMonitor_RESOURCE_FILES += $(THEOS_OBJ_DIR_NAME)/$(wildcard *.nib)

MobileActivityMonitor_RESOURCE_XIB = $(wildcard MobileAM/UI/*.xib)
MobileActivityMonitor_RESOURCE_NIB = $(MobileActivityMonitor_RESOURCE_XIB:.xib=.nib)

%.nib:
	ibtool --compile $(THEOS_OBJ_DIR_NAME)/$(notdir $@) $*.xib --sdk $(SYSROOT)

all::	$(MobileActivityMonitor_RESOURCE_NIB)

include $(THEOS_MAKE_PATH)/application.mk

after-install::
	install.exec "killall \"MobileActivityMonitor\"" || true
