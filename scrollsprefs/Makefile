ARCHS = arm64 arm64e

SDKVERSION = 13.5

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = scrollsprefs

scrollsprefs_FILES = STTRootListController.m
scrollsprefs_INSTALL_PATH = /Library/PreferenceBundles
scrollsprefs_FRAMEWORKS = UIKit
scrollsprefs_EXTRA_FRAMEWORKS += Cephei CepheiPrefs
scrollsprefs_PRIVATE_FRAMEWORKS = Preferences
scrollsprefs_CFLAGS = -fobjc-arc
scrollsprefs_LIBRARIES = sparkapplist

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/scrollsprefs.plist$(ECHO_END)
