//
//  FriendTableViewCell.h
//  核心动画
//
//  Created by 朱伟阁 on 2019/1/27.
//  Copyright © 2019 朱伟阁. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FriendModel;
NS_ASSUME_NONNULL_BEGIN

@interface FriendTableViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *headerImageView;//头像
@property (nonatomic,strong)UILabel *labelName;
@property (nonatomic,strong)UILabel *labelroleName;
+ (instancetype)friendTableViewCellWithTableView:(UITableView *)tableview;

@property(nonatomic, strong) FriendModel *friendModel;

@end

NS_ASSUME_NONNULL_END
