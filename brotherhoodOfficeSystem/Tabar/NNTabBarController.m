//
//  NNTabBarController.m
//  NNJaneBookView
//
//  Created by 柳钟宁 on 2017/8/4.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

#import "NNTabBarController.h"
#import "NNNavigationController.h"

@interface NNTabBarController ()
@property (nonatomic, weak) UIButton *composeButton;

@end

@implementation NNTabBarController

#pragma mark - 统一设置所有 UITabBarItem 的文字属性
+ (void)initialize {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = RGB(51, 51, 51);
    
    UITabBarItem *items = [UITabBarItem appearance];
    [items setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [items setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

#pragma mark - 初始化
- (instancetype)init {
    if (self = [super init]) {
        [self addChildViewControllers];
//        [self addComposeButton];
    }
    return self;
}

#pragma mark - 添加所有子控制器
- (void)addChildViewControllers {
    [self addChildViewControllerClassName:@"HomepageController" title:@"工作" imageName:@"dibutel"];
    [self addChildViewControllerClassName:@"AccountViewController" title:@"巡检" imageName:@"xunjian"];
//    [self addChildViewController: [[UIViewController alloc] init]];
    [self addChildViewControllerClassName:@"MyCityViewController" title:@"我的" imageName:@"wd"];
}

#pragma mark - 设置所有子控制器
- (void)addChildViewControllerClassName:(NSString *)className title:(NSString *)title imageName:(NSString *)imageName
{
    UIViewController *viewController = [[NSClassFromString(className) alloc] init];
    NNNavigationController *nav = [[NNNavigationController alloc] initWithRootViewController:viewController];
    viewController.title = title;
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.tabBarItem.image = [[UIImage imageNamed: imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"sel%@", imageName]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}

#pragma mark - 添加中间的按钮
/**
- (void)addComposeButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"tabBar_publish_icon_highlighted"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(composeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.composeButton = button;
    [self.tabBar addSubview:button];
    [self.tabBar bringSubviewToFront:button];
    CGFloat width = self.tabBar.bounds.size.width / self.childViewControllers.count - 2;
    self.tabBar.tintColor = [UIColor colorWithRed:68/255.0 green:173/255.0 blue:159/255.0 alpha:1];
    button.frame = CGRectInset(self.tabBar.bounds, 2 * width, 0);
}

#pragma mark - 点击写文章按钮
- (void)composeButtonClick:(UIButton *)button {
    NSLog(@"\n点击了写文章按钮");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBar bringSubviewToFront:self.composeButton];
}
***/
@end
