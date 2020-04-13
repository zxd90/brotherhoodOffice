//
//  timeLineModel.h
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/12.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    WuliuCellPositionMid,
    WuliuCellPositionTop,
    WuliuCellPositionTail,
} WuliuCellPosition;
NS_ASSUME_NONNULL_BEGIN

@interface timeLineModel : NSObject
///时间
@property (nonatomic, copy) NSString *time;
///物流
@property (nonatomic, copy) NSString *context;
///行高
@property (nonatomic, assign) CGFloat rowHeight;
///区分第一行还是最后一行,默认中间
@property (nonatomic, assign) WuliuCellPosition wuliuCellPosition;

+ (NSArray *)modelArrayWithDictArray:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
