#import "Tweak.h"

@interface STTScrollView : UIScrollView
-(BOOL)scrollsToTop;
@end

%hook STTScrollView

-(BOOL)scrollsToTop {
    return false;
}

%end

%ctor {
	HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"com.ajaidan.scrollsprefs"];
	[preferences registerBool:&isEnabled default:FALSE forKey:@"isEnabled"];

	if (!isEnabled) {return;}

	NSString* bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier]; // This is dependent on where it is called, may not be the correct method for your tweak!

    if([SparkAppList doesIdentifier:@"com.ajaidan.scrollsprefs" andKey:@"apps" containBundleIdentifier:bundleIdentifier]) {
		%init(STTScrollView=objc_getClass("UIScrollView"));
    } else {return;}
}