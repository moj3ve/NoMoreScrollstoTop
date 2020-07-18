#import "Tweak.h"

@interface UIStatusBarManager ()
-(void)handleStatusBarTapWithEvent:(id)arg1 ;
@end

%group Tweak
%hook UIStatusBarManager

-(void)handleStatusBarTapWithEvent:(id)arg1 {
	
}

%end
%end

%ctor {
	HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"com.ajaidan.scrollsprefs"];
	[preferences registerBool:&isEnabled default:FALSE forKey:@"isEnabled"];

	if (!isEnabled) {return;}

	NSString* bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier]; // This is dependent on where it is called, may not be the correct method for your tweak!

    if([SparkAppList doesIdentifier:@"com.ajaidan.scrollsprefs" andKey:@"apps" containBundleIdentifier:bundleIdentifier]) {
		%init(Tweak);
    } else {return;}
}