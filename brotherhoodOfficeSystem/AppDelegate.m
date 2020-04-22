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
 #define JPushSDK_AppKey  @"50690ec6899b9369ff60e9f6"
 #ifdef NSFoundationVersionNumber_iOS_9_x_Max
 #import <UserNotifications/UserNotifications.h>
 #endif
#ifdef DEBUG // 开发
static BOOL const isProduction = FALSE; // 极光FALSE为开发环境
#else // 生产
static BOOL const isProduction = TRUE; // 极光TRUE为生产环境
#endif
static BOOL isBackGroundActivateApplication;
@interface AppDelegate ()<JPUSHRegisterDelegate>
{
    int badge;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    badge = 0;
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
         entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
            [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |UIUserNotificationTypeSound |
                UIUserNotificationTypeAlert)
        categories:nil];
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
               [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    //极光
    [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(networkDidSetup:)name:kJPFNetworkDidSetupNotification
    object:nil];
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:JPushSDK_AppKey
                          channel:@"App Store"
                 apsForProduction:isProduction];
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
  
            [JPUSHService setAlias: [NSString stringWithFormat:@"%@",kFetchMyDefault (@"asName")] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            } seq:0];
        }
        else{
          // NSLog(@"registrationID获取失败，code：%d",resCode);
        }
       
    }];
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
- (void)networkDidSetup:(NSNotification *)notification
{
    //针对设备给极光服务器反馈了别名，app服务端可以用别名来针对性推送消息
    [JPUSHService setAlias: [NSString stringWithFormat:@"%@",kFetchMyDefault (@"asName")] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
    } seq:0];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
 
    [JPUSHService handleRemoteNotification:userInfo];
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    //推送显示的内容
 //  NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    badge++;
    [UIApplication sharedApplication].applicationIconBadgeNumber =5;
    [JPUSHService setBadge:5];
    //1.应用程序处在前台
    if (application.applicationState == UIApplicationStateActive) {
//        self.userInfo=userInfo;
//        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//         //点确定跳到相应的界面。
//        [alertView show];
        
    }else if (application.applicationState == UIApplicationStateInactive && !isBackGroundActivateApplication)
    {
        [self goToMssageViewControllerWith:userInfo];
    }
    // 应用在后台。当后台设置aps字段里的 content-available 值为 1 并开启远程通知激活应用的选项
    if (application.applicationState == UIApplicationStateBackground) {
       
//        self.userInfo=userInfo;
         
//        isBackGroundActivateApplication = YES;
//        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alertView show];
    }
       completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
// 当程序在前台时, 收到推送弹出的通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler
API_AVAILABLE(ios(10.0)){
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo];
    }
     [self goToMssageViewControllerWith:userInfo];
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}
//添加处理 APNs 通知回调方法
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification API_AVAILABLE(ios(10.0)){
    if (@available(iOS 10.0, *)) {
        if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            badge=0;
            //从通知界面直接进入应用
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
            [JPUSHService setBadge:0];
        }else{
            //从通知设置界面进入应用
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
            [JPUSHService setBadge:0];
        }
    } else {
        // Fallback on earlier versions
    }
}
// 程序关闭后, 通过点击推送弹出的通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
API_AVAILABLE(ios(10.0)){
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    
    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo];
    }
     [self goToMssageViewControllerWith:userInfo];
    completionHandler();  // 系统要求执行这个方法
}

- (void)jpushNotificationAuthorization:(JPAuthorizationStatus)status withInfo:(NSDictionary *)info {
    
}


#endif

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 1) {
//
//    [self goToMssageViewControllerWith:self.userInfo];
//    }
//}

// 反馈给服务器
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    // 应用在前台 或者后台开启状态下，不跳转页面，让用户选择。
    [JPUSHService handleRemoteNotification:userInfo];
    
   
    if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
//         self.userInfo=userInfo;
//        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alertView show];
        
    }
    else//杀死状态下，直接跳转到跳转页面。
    {
       [self goToMssageViewControllerWith:userInfo];
        
    }
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 注册设备处调用推送
    [JPUSHService registerDeviceToken:deviceToken];
}

//点击App图标，使App从后台恢复至前台,程序进入前台(去掉这个\)去掉小红点
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
}
//按Home键使App进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application{
[application setApplicationIconBadgeNumber:0];
[application cancelAllLocalNotifications];
}
- (void)goToMssageViewControllerWith:(NSDictionary*)msgDic{
    //将字段存入本地，因为要在你要跳转的页面用它来判断,这里我只介绍跳转一个页面，
//    NSUserDefaults*pushJudge = [NSUserDefaults standardUserDefaults];
//    [pushJudge setObject:@"push"forKey:@"push"];
//    [pushJudge synchronize];
//
//    UISplitViewController * VC = [[UISplitViewController alloc]init];
//        UINavigationController * Nav = [[UINavigationController alloc]initWithRootViewController:VC];//这里加导航栏是因为我跳转的页面带导航栏，如果跳转的页面不带导航，那这句话请省去。
//        [self.window.rootViewController presentViewController:Nav animated:YES completion:nil];
//
//   // }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
