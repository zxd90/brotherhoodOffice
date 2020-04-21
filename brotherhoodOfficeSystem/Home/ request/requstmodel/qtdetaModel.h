//
//  qtdetaModel.h
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/18.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import <Foundation/Foundation.h>
@class rqtDetModel;
NS_ASSUME_NONNULL_BEGIN

@interface qtdetaModel : NSObject
/**名字*/
@property (nonatomic, copy) NSString *userName;
/**部门*/
@property (nonatomic, copy) NSString *depName;
/**职位*/
@property (nonatomic, assign) NSString *roleName;
/**事由*/
@property (nonatomic, assign) NSString *matterType;
/**事由说明*/
@property (nonatomic, assign) NSString *reason;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)qtdetaWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
