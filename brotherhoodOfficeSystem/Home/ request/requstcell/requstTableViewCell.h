//
//  requstTableViewCell.h
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/18.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class  requstModel;
@interface requstTableViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *headerImageView;//头像
/**名字*/
@property (nonatomic,strong)UILabel *labelName;
/**职位*/
@property (nonatomic,strong)UILabel *labelroleName;
/**流程主题*/
@property (nonatomic,strong)UILabel *matterName;
/**发起时间*/
@property (nonatomic,strong)UILabel *timeName;
@property(nonatomic, strong)requstModel *requstModel;
+ (instancetype)requstTableViewCellWithTableView:(UITableView *)tableview;
@end

NS_ASSUME_NONNULL_END
