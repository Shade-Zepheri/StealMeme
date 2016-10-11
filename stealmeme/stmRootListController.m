#include "stmRootListController.h"

@implementation stmRootListController

- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"StealMeme" target:self] retain];
	}
	return _specifiers;
}

-(id) bundle {
	return [NSBundle bundleForClass:[self class]];
}

-(id) readPreferenceValue:(PSSpecifier*)specifier {
	NSDictionary *SMSettings = [NSDictionary dictionaryWithContentsOfFile:SMPrefsPath];
	if (!SMSettings[specifier.properties[@"key"]]) {
		return specifier.properties[@"default"];
	}
	return SMSettings[specifier.properties[@"key"]];
}

-(void) setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
	NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
	[defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:SMPrefsPath]];
	[defaults setObject:value forKey:specifier.properties[@"key"]];
	[defaults writeToFile:SMPrefsPath atomically:YES];
	CFStringRef SMPost = (CFStringRef)specifier.properties[@"PostNotification"];
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), SMPost, NULL, NULL, YES);
}

@end
