//
//  haveCell.h
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/18.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HaveModel;
NS_ASSUME_NONNULL_BEGIN

@interface haveCell : UITableViewCell
@property (strong, nonatomic) UIImageView *headerImageView;//头像
/**名字*/
@property (nonatomic,strong)UILabel *labelName;
/**职位*/
@property (nonatomic,strong)UILabel *labelroleName;
/**流出主题*/
@property (nonatomic,strong)UILabel *matterName;
/**发起时间*/
@property (nonatomic,strong)UILabel *timeName;
@property(nonatomic, strong)HaveModel *haveModel;
+ (instancetype)haveTableViewCellWithTableView:(UITableView *)tableview;
@end

NS_ASSUME_NONNULL_END
