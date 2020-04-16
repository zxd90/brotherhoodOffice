//
//  ChopersonController.h
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/15.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendModel.h"
typedef void  (^BAELOCKck)(FriendModel *Friend);
typedef void  (^BAELOCK)(FriendModel *Friend);
NS_ASSUME_NONNULL_BEGIN

@interface ChopersonController : UIViewController
//传参数
@property (nonatomic,copy)BAELOCKck blcokFriendStr;
//传参数
@property (nonatomic,copy)BAELOCK blcokworkStr;
@property (nonatomic,assign)int num;
@end

NS_ASSUME_NONNULL_END
