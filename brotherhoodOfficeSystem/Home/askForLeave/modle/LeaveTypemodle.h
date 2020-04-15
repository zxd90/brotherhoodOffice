//
//  LeaveTypemodle.h
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/15.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeaveTypemodle : NSObject
@property(nonatomic,strong)NSString *flowTypeName;
+ (NSArray *)modelArrayWithDictArray:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
