ARCHS = arm64 arm64e

SDKVERSION = 13.5

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NoMoreScrollstoTop

NoMoreScrollstoTop_FILES = Tweak.xm
NoMoreScrollstoTop_EXTRA_FRAMEWORKS += Cephei
NoMoreScrollstoTop_CFLAGS = -fobjc-arc
NoMoreScrollstoTop_LIBRARIES = sparkapplist

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += scrollsprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
