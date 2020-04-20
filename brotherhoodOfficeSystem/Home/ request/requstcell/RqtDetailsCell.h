//
//  RqtDetailsCell.h
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/18.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import <UIKit/UIKit.h>
@class rqtDetModel;
NS_ASSUME_NONNULL_BEGIN

@interface RqtDetailsCell : UITableViewCell
/**圆点*/
 @property (nonatomic,strong) UIView *roundView;
@property (strong, nonatomic) UIImageView *headerImageView;//头像
/**姓名 */
 @property (nonatomic,strong) UILabel *titleLabel;
/**职位*/
 @property (nonatomic,strong) UILabel *contentlabel;
/**时间*/
 @property (nonatomic,strong) UILabel *timelabel;
/**处理状态*/
@property (nonatomic,strong)UILabel *matterName;
/**处理内容*/
@property (nonatomic,strong)UILabel *Proces;
/**线*/
 @property (nonatomic,strong) UILabel *onLine;
/**线*/
 @property (nonatomic,strong)  UILabel *downLine;
@property (nonatomic, strong) rqtDetModel *model;
+ (instancetype)rqtDetTableViewCellWithTableView:(UITableView *)tableview;
@end

NS_ASSUME_NONNULL_END
