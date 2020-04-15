//
//  LeaveTypemodle.m
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/15.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "LeaveTypemodle.h"

@implementation LeaveTypemodle
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
        LeaveTypemodle *model = [[[LeaveTypemodle alloc] init]  initWithDict:dict];
        [tempArray addObject:model];
    }
    return tempArray;
}
@end
