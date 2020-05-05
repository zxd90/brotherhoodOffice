//
//  YearsTime.h
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/5/5.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YearsTime : NSObject
/**
*  获取当天的年月日的字符串
*  这里测试用
*  @return 格式为时-分-秒
*/
+(NSString *)getHhmmss;
/**
*  获取当天的年月日的字符串
*  这里测试用
*  @return 格式为年-月-日
*/
+(NSString *)getyyyymmdd;
@end

NS_ASSUME_NONNULL_END
