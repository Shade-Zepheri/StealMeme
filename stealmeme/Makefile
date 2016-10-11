include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = stealmeme
stealmeme_FILES = stmRootListController.m
stealmeme_INSTALL_PATH = /Library/PreferenceBundles
stealmeme_FRAMEWORKS = UIKit
stealmeme_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/stealmeme.plist$(ECHO_END)
