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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    IQKeyboardManager *managerr = [IQKeyboardManager sharedManager];
     managerr.enable = YES;
  managerr.toolbarDoneBarButtonItemText = @"完成"; managerr.overrideKeyboardAppearance = YES;
    managerr.shouldResignOnTouchOutside = YES;
    managerr.enableAutoToolbar = YES;
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
