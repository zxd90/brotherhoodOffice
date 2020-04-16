//
//  FriendModel.h
//  核心动画
//
//  Created by 朱伟阁 on 2019/1/26.
//  Copyright © 2019 朱伟阁. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FriendModel : NSObject

@property(nonatomic, copy) NSString *headImg;
@property(nonatomic, copy) NSString *roleName;
@property(nonatomic, copy) NSString *userName;
@property(nonatomic, assign)int  userId;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)friendWithDict:(NSDictionary *)dict;

//+ (NSDictionary *)mj_replacedKeyFromPropertyName;

@end

NS_ASSUME_NONNULL_END
