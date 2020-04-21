//
//  AppDelegate.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/3/17.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "AppDelegate.h"
#import "NNTabBarController.h"
#import "LoginViewController.h"
 #define JPushSDK_AppKey  @"2a1cb6aa16e94531ef0c1ba7"
 #define Production     NO
 #ifdef NSFoundationVersionNumber_iOS_9_x_Max
 #import <UserNotifications/UserNotifications.h>
 #endif
@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        // Fallback on earlier versions
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
//    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    [JPUSHService setupWithOption:launchOptions appKey:JPushSDK_AppKey
                          channel:@"App Store"
                 apsForProduction:Production
            advertisingIdentifier:advertisingId];
     IQKeyboardManager *managerr = [IQKeyboardManager sharedManager];
    IQKeyboardManager.sharedManager.toolbarDoneBarButtonItemText = @"完成";
    managerr.shouldToolbarUsesTextFieldTintColor = NO;
    managerr.toolbarTintColor = [UIColor blackColor];
//     self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    if () {
//    self.window.rootViewController = [[LoginViewController alloc]init];
//    }else{
//         self.window.rootViewController = [[NNTabBarController alloc] init];
//    }
//
//        [self.window makeKeyAndVisible];
    [self setupLoginViewController];

    return YES;
}
//登录页面
-(void)setupLoginViewController
{
    LoginViewController *logInVc = [[LoginViewController alloc]init];
    self.window.rootViewController = logInVc;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

@end
