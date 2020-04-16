//
//  todoTableViewCell.h
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/16.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface todoTableViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *headerImageView;//头像
@property (nonatomic,strong)UILabel *labelName;
@property (nonatomic,strong)UILabel *labelroleName;
+ (instancetype)friendTableViewCellWithTableView:(UITableView *)tableview;
@end

NS_ASSUME_NONNULL_END
