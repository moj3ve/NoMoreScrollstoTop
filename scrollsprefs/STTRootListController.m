#include "STTRootListController.h"

@interface STTSwitchCell : PSSwitchTableCell
-(UIColor *)colorFromHex:(NSString *)hex withAlpha:(CGFloat)alpha;
@end

@implementation STTSwitchCell {
  UIColor *_switchColor;
}

  -(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier specifier:(PSSpecifier *)specifier {
    self = [super initWithStyle:style reuseIdentifier:identifier specifier:specifier];

    if(self) {
      ((UISwitch *)self.control).onTintColor = [self colorFromHex:[specifier propertyForKey:@"switchColor"] withAlpha:[[specifier propertyForKey:@"switchColorAlpha"] floatValue]];
    }

    return self;
  }

  -(UIColor *)colorFromHex:(NSString *)hex withAlpha:(CGFloat)alpha {   
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&rgbValue];

    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0x00FF00) >> 8)) / 255.0 blue:((float)((rgbValue & 0x0000FF) >> 0)) / 255.0 alpha:alpha];
  }
@end

@implementation STTRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

-(id)init {
	self = [super init];
	if(self) {
		HBAppearanceSettings *appearanceSettings = [[HBAppearanceSettings alloc] init];
		appearanceSettings.navigationBarTintColor = [UIColor whiteColor];
		appearanceSettings.navigationBarTitleColor = [UIColor whiteColor];
		appearanceSettings.navigationBarBackgroundColor = [UIColor colorWithRed: 0.74 green: 0.54 blue: 0.98 alpha: 1.00];
		appearanceSettings.tableViewCellSeparatorColor = [UIColor clearColor];
		appearanceSettings.translucentNavigationBar = NO;
		self.hb_appearanceSettings = appearanceSettings;
		UIBarButtonItem *respringButton = [[UIBarButtonItem alloc]
                                initWithTitle:@"Apply"
                                style:UIBarButtonItemStylePlain
                                target:self
                                action:@selector(respring)];
		self.navigationItem.rightBarButtonItem = respringButton;
	}

	return self;
}

- (void)selectApps {
  SparkAppListTableViewController* s = [[SparkAppListTableViewController alloc] initWithIdentifier:@"com.ajaidan.scrollsprefs" andKey:@"Apps"];

    [self.navigationController pushViewController:s animated:YES];
	s.navigationItem.title = @"Select Apps";
    self.navigationItem.hidesBackButton = FALSE;

}

- (void)respring {
  [HBRespringController respringAndReturnTo:[NSURL URLWithString:@"prefs:root=NoMoreScrollstoTop"]];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	UIBarButtonItem *respringButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Apply"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(respring)];
	self.navigationItem.rightBarButtonItem = respringButton;
}

@end
