ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ScrollsPrefs

ScrollsPrefs_FILES = STTRootListController.m STTAppearanceSettings.m
ScrollsPrefs_INSTALL_PATH = /Library/PreferenceBundles
ScrollsPrefs_FRAMEWORKS = UIKit
ScrollsPrefs_EXTRA_FRAMEWORKS += Cephei CepheiPrefs
ScrollsPrefs_PRIVATE_FRAMEWORKS = Preferences
ScrollsPrefs_CFLAGS = -fobjc-arc
ScrollsPrefs_LIBRARIES = sparkapplist

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/scrollsprefs.plist$(ECHO_END)
