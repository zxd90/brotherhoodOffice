//
//  AppDelegate.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/3/17.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "AppDelegate.h"
#import "NNTabBarController.h"
#import "NNNavigationController.h"
#import "LoginViewController.h"
#import "todetailsVC.h"
#import "WZXLaunchViewController.h"
#import "HomeWebViewController.h"
#define JPushSDK_AppKey  @"50690ec6899b9369ff60e9f6"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#ifdef DEBUG // 开发
static BOOL const isProduction = FALSE; // 极光FALSE为开发环境
#else // 生产
static BOOL const isProduction = TRUE; // 极光TRUE为生产环境
#endif
@interface AppDelegate ()<JPUSHRegisterDelegate>
@property (nonatomic,retain)NSDictionary *userInfo;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 要使用百度地图，请先启动BaiduMapManager
      BMKMapManager *mapManager = [[BMKMapManager alloc] init];
      // 如果要关注网络及授权验证事件，请设定generalDelegate参数
      BOOL ret = [mapManager start:@"zhjWZUxfzGx8mqIWSherE99ikvuzIim0"generalDelegate:nil];
      if (!ret) {
      ZLog(@"启动引擎失败");
      }
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
  
     self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
     self.window.backgroundColor = [UIColor whiteColor];
     [self addNavBartion];
   // [self ZXLaunchView];
     [self.window makeKeyAndVisible];
    return YES;
}
-(void)addNavBartion{
    
    if ([kFetchMyDefault (@"asName") length]==0) {
    self.window.rootViewController = [[LoginViewController alloc]init];
    }else{
         self.window.rootViewController = [[NNTabBarController alloc] init];
    }
   
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
     NSLog(@"==3213132==______%@",userInfo);
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]])
    {
        [JPUSHService handleRemoteNotification:userInfo];
        /// 前台收到推送的时候 转成本地通知
               UILocalNotification *notification = [[UILocalNotification alloc] init];
               notification.alertTitle = @"收到一条新消息";

               notification.alertBody = userInfo[@"aps"][@"alert"];

               notification.userInfo = userInfo;
        NSLog(@"==3213132==______%@",userInfo);
    }
   //前台接受参数
     [self goToMssageViewControllerWith:userInfo];
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}
//添加处理 APNs 通知回调方法
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification API_AVAILABLE(ios(10.0)){
    if (@available(iOS 10.0, *)) {
        if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
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
       NSLog(@"+++++====______%@",userInfo);
      //接受参数
     [self goToMssageViewControllerWith:userInfo];
    completionHandler();  // 系统要求执行这个方法
}

- (void)jpushNotificationAuthorization:(JPAuthorizationStatus)status withInfo:(NSDictionary *)info {
    
}


#endif

// 注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
//点击App图标，使App从后台恢复至前台,程序进入前台(去掉这个\)去掉小红点
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService resetBadge];
}
//按Home键使App进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application{
[application setApplicationIconBadgeNumber:0];
[application cancelAllLocalNotifications];
[JPUSHService resetBadge];
}
- (void)goToMssageViewControllerWith:(NSDictionary*)msgDic{

   NNTabBarController *tab = (NNTabBarController *)_window.rootViewController;
   NNNavigationController *nav = tab.viewControllers[tab.selectedIndex];
     todetailsVC *vc = [[todetailsVC alloc] init];
     vc.hidesBottomBarWhenPushed = YES;
     [nav pushViewController:vc animated:NO];
   
}
- (void)ZXLaunchView{
    NSString *gifImageURL = @"http://img1.gamedog.cn/2013/06/03/43-130603140F30.gif";
    
    NSString *imageURL = @"http://img4.duitang.com/uploads/item/201410/24/20141024135636_t2854.thumb.700_0.jpeg";
    ///设置启动页
    [WZXLaunchViewController showWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-150) ImageURL:gifImageURL advertisingURL:@"http://www.jianshu.com/p/7205047eadf7" timeSecond:3 hideSkip:YES imageLoadGood:^(UIImage *image, NSString *imageURL) {
        /// 广告加载结束
        NSLog(@"%@ %@",image,imageURL);
        
    } clickImage:^(UIViewController *WZXlaunchVC){
        //2. 点击广告在webview中打开
//        HomeWebViewController *VC = [[HomeWebViewController alloc] init];
//        VC.urlStr = @"http://www.jianshu.com/p/7205047eadf7";
//        VC.title = @"广告";
//        VC.AppDelegateSele= -1;
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
//        [WZXlaunchVC presentViewController:nav animated:YES completion:nil];
    } theAdEnds:^{
        //广告展示完成回调,设置window根控制器
        [self addNavBartion];
    }];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
 

@end
