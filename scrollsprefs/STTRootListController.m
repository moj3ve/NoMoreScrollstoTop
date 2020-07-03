#include "STTRootListController.h"
#import "SparkAppListTableViewController.h"
#import <Foundation/Foundation.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSSwitchTableCell.h>
#import <AudioToolbox/AudioServices.h>
#import <SpringBoard/SpringBoard.h>
#import <SpringBoardServices/SBSRestartRenderServerAction.h>
#import <FrontBoardServices/FBSSystemService.h>
#import <Preferences/PreferencesAppController.h>

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

- (id)readPreferenceValue:(PSSpecifier*)specifier {
	NSString *path = [NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
	return (settings[specifier.properties[@"key"]]) ?: specifier.properties[@"default"];
}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
	NSString *path = [NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
	[settings setObject:value forKey:specifier.properties[@"key"]];
	[settings writeToFile:path atomically:YES];
	CFStringRef notificationName = (__bridge CFStringRef)specifier.properties[@"PostNotification"];
	if (notificationName) {
		CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), notificationName, NULL, NULL, YES);
	}
}

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIColor *tintColor = [UIColor colorWithRed: 0.74 green: 0.54 blue: 0.98 alpha: 1.00];
    [[[[self navigationController] navigationController] navigationBar] setTintColor:tintColor];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIView animateWithDuration:1.0 animations:^{
        [[[[self navigationController] navigationController] navigationBar] setTintColor:nil];
    }];
}

- (void)sourceLink {
	AudioServicesPlaySystemSound(1520);
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/ajaidan0/nomorescrollstotop"] options:@{} completionHandler:nil];
}

- (void)donate {
	AudioServicesPlaySystemSound(1520);
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://paypal.me/ajaidan"] options:@{} completionHandler:nil];
}

- (void)discord {
	AudioServicesPlaySystemSound(1520);
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://discord.gg/w8pvXJd"] options:@{} completionHandler:nil];
}

- (void)selectApps {
  SparkAppListTableViewController* s = [[SparkAppListTableViewController alloc] initWithIdentifier:@"com.ajaidan.scrollsprefs" andKey:@"Apps"];

    [self.navigationController pushViewController:s animated:YES];
	s.navigationItem.title = @"Select Apps";
    self.navigationItem.hidesBackButton = FALSE;

}

- (void)respring {
	AudioServicesPlaySystemSound(1520);
	NSURL *returnURL = [NSURL URLWithString:@"prefs:root=NoMoreScrollstoTop"]; 
    SBSRelaunchAction *restartAction;
    restartAction = [NSClassFromString(@"SBSRelaunchAction") actionWithReason:@"RestartRenderServer" options:SBSRelaunchActionOptionsFadeToBlackTransition targetURL:returnURL];
    [[NSClassFromString(@"FBSSystemService") sharedService] sendActions:[NSSet setWithObject:restartAction] withResult:nil];
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
