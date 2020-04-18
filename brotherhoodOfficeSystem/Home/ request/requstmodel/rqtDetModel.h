//
//  rqtDetModel.h
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/18.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    WuliuCellPositionMid,
    WuliuCellPositionTop,
    WuliuCellPositionTail,
} WuliuCellPosition;
NS_ASSUME_NONNULL_BEGIN

@interface rqtDetModel : NSObject
///时间
@property (nonatomic, copy) NSString *checkTime;
///职位
@property (nonatomic, copy) NSString *roleName;

///姓名
@property (nonatomic, copy) NSString *userName;
///批示内容
@property (nonatomic, copy) NSString *remarks;
///处理状态
@property (nonatomic, copy) NSString *isCheck;
///行高
@property (nonatomic, assign) CGFloat rowHeight;
///区分第一行还是最后一行,默认中间
@property (nonatomic, assign) WuliuCellPosition wuliuCellPosition;
+ (instancetype)rqtDetWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
