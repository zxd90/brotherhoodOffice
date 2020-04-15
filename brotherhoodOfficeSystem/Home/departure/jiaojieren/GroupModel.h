//
//  GroupModel.h
//  核心动画
//
//  Created by 朱伟阁 on 2019/1/26.
//  Copyright © 2019 朱伟阁. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FriendModel;

NS_ASSUME_NONNULL_BEGIN

@interface GroupModel : NSObject

@property(nonatomic, strong) NSArray<FriendModel *> *users;
@property(nonatomic, copy) NSString *depName;
@property(nonatomic, copy) NSString *total;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)groupWithDict:(NSDictionary *)dict;

+ (NSDictionary *)mj_objectClassInArray;

@property(nonatomic, assign,getter=isVisible) BOOL visible;

@end

NS_ASSUME_NONNULL_END
