// NoMoreScrollstoTop
// Copyright (c) ajaidan0 2020

#import <Cephei/HBPreferences.h>
#import <SparkAppList.h>

BOOL isEnabled;

%group Tweak
%hook UIScrollView

-(id)initWithFrame:(CGRect)frame {
    self = %orig;
    self.scrollsToTop = false;
    return self;
}

-(id)initWithCoder:(id)arg1 {
    self = %orig;
    self.scrollsToTop = false;
    return self;
}

%end
%end

%ctor {
	HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"com.ajaidan.scrollsprefs"];
	[preferences registerBool:&isEnabled default:FALSE forKey:@"isEnabled"];

	if (!isEnabled) {return;}

    // Thanks, SparkDev!

	NSString* bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];

    if([SparkAppList doesIdentifier:@"com.ajaidan.scrollsprefs" andKey:@"apps" containBundleIdentifier:bundleIdentifier]) {
		%init(Tweak);
    } else {return;}
}