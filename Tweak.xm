#define SMPrefsPath @"/User/Library/Preferences/com.shade.stealmeme.plist"
static BOOL enabled = YES;

static void initPrefs() {
	NSDictionary *SMSettings = [NSDictionary dictionaryWithContentsOfFile:SMPrefsPath];
	enabled = ([SMSettings objectForKey:@"enabled"] ? [[SMSettings objectForKey:@"enabled"] boolValue] : enabled);
}

%hook _UIActivityGroupActivityCellTitleLabel

-(void)setText:(NSString *)arg1 {
	if (enabled) {
		arg1 = [arg1 stringByReplacingOccurrencesOfString:@"Save Image" withString:@"Steal Meme" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1 length])];
	}
	%orig(arg1);
}

%end

%hook UILabel

-(void)setText:(NSString *)arg1 {
	if (enabled) {
		arg1 = [arg1 stringByReplacingOccurrencesOfString:@"Save Image" withString:@"Steal Meme" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [arg1 length])];
	}
	%orig(arg1);
}

%end

%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)initPrefs, CFSTR("com.shade.stealmeme/ReloadPrefs"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	initPrefs();
}
