//
//  HaveModel.h
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/18.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HaveModel : NSObject
/**时间 */
@property(nonatomic, strong) NSString *createTime;
/** 事项*/
@property(nonatomic, strong) NSString *matterName;
/** 头像*/
@property(nonatomic, strong) NSString *headImg;
/** 名字*/
@property(nonatomic, strong) NSString *userName;
/**职位*/
@property(nonatomic, strong) NSString *roleName;
/**流程ID*/
@property(nonatomic, strong) NSString *matterId;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)haveWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
