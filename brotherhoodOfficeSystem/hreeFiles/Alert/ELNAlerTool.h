//
//  ELNAlerTool.h
//  AutomicCloseAlertDemo
//
//  Created by Elean on 16/1/11.
//  Copyright (c) 2016年 Elean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ELNAlerTool : NSObject
//显示提示 并且在time秒之后自动关闭提示框
+ (void)showAlertMassgeWithController:(UIViewController *)ctr  andMessage:(NSString *)message andInterval:(NSTimeInterval)time;
+(CGFloat)heighOfString:(NSString*)string font:(UIFont*)font width:(CGFloat)width;
+(void)leftItiemButtonImagePopWithController:(UIViewController *)ctr;
+(void)buttonLiftItem:(UIButton*)sender cvt:(UIAlertController *)vc;

+(NSString *)toJSONData:(id)theData;
@end
