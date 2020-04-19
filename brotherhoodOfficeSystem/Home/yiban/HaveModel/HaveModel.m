//
//  HaveModel.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/18.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "HaveModel.h"

@implementation HaveModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+ (instancetype)haveWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
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
