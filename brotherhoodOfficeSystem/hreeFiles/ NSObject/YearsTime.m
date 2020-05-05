//
//  YearsTime.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/5/5.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "YearsTime.h"

@implementation YearsTime
/**
 *  获取当天的年月日的字符串
 *  这里测试用
 *  @return 格式为年-月-日
 */
+(NSString *)getyyyymmdd{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyy-MM-dd";
    NSString *dayStr = [formatDay stringFromDate:now];
    return dayStr;
    
}
/**
 *  获取当天的年月日的字符串
 *  这里测试用
 *  @return 格式为时-分-秒
 */
+(NSString *)getHhmmss{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"HH:mm:ss";
    NSString *dayStr = [formatDay stringFromDate:now];
    return dayStr;
    
}

@end
