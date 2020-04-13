//
//  timeLineModel.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/12.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "timeLineModel.h"

@implementation timeLineModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (NSArray *)modelArrayWithDictArray:(NSArray *)array{
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        timeLineModel *model = [[[timeLineModel alloc] init]  initWithDict:dict];
        [tempArray addObject:model];
    }
    return tempArray;
}
@end
