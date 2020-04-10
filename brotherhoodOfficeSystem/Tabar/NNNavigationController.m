//
//  NNNavigationController.m
//  NNJaneBookView
//
//  Created by 柳钟宁 on 2017/8/5.
//  Copyright © 2017年 zhongNing. All rights reserved.
//

#import "NNNavigationController.h"

@interface NNNavigationController ()

@end

@implementation NNNavigationController

+ (void)initialize {
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBarTintColor:[UIColor whiteColor]];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [bar setTitleTextAttributes:attrs];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"bolk"] forState:UIControlStateNormal];
        button.frame =CGRectMake(0, 0, 30, 30);

        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -12, 0, 0)];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftButon= [[UIBarButtonItem alloc] initWithCustomView:button];
        UIBarButtonItem *fixedButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFixedSpace target:nil action:nil];

        fixedButton.width= -15;
        viewController.navigationItem.leftBarButtonItems= @[fixedButton,leftButon];
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

@end
