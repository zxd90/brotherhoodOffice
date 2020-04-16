//
//  GroupModel.m
//  核心动画
//
//  Created by 朱伟阁 on 2019/1/26.
//  Copyright © 2019 朱伟阁. All rights reserved.
//

#import "GroupModel.h"
#import "FriendModel.h"

@implementation GroupModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dict_sub in self.users) {
            FriendModel *model = [FriendModel friendWithDict:dict_sub];
            [arrayModels addObject:model];
        }
        self.users = arrayModels;
    }
    return self;
}

+ (instancetype)groupWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

+ (NSDictionary *)mj_objectClassInArray{
    //前边是属性数组的名字，后边是类
    return @{
             @"users":@"FriendModel"
             };
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    
}
//kvc取值操作  取值误操作
-(instancetype)valueForUndefinedKey:(NSString *)key
{
    return nil;
}
@end
