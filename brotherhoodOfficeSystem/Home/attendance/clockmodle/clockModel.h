//
//  clockModel.h
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/29.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface clockModel : NSObject
/**上班时间*/
@property(nonatomic,strong)NSString *time;
/**打卡地点*/
@property(nonatomic,strong)NSString *clockAddr;
/**打卡时间*/
@property(nonatomic,strong)NSString *clockTime;
/**打卡位置*/
@property(nonatomic,strong)NSString *realClockAddr;
/** */
@property(nonatomic,strong)NSString *flag;
/**打卡状态*/
@property(nonatomic,strong)NSString *tags;
+ (instancetype)clockDetWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
