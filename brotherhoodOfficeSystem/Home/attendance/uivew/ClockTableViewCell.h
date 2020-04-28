//
//  ClockTableViewCell.h
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/28.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClockTableViewCell : UITableViewCell
/**圆点*/
@property (nonatomic,strong) UIView *roundView;
/**线*/
 @property (nonatomic,strong) UILabel *onLine;
/**线*/
 @property (nonatomic,strong)  UILabel *downLine;
/**上下班时间*/
@property (nonatomic,strong) UILabel *timelabel;
/**打卡时间 */
 @property (nonatomic,strong) UILabel *clockLabel;
/**打卡状态*/
 @property (nonatomic,strong) UILabel *statelabel;
/**坐标图标*/
@property (strong, nonatomic) UIImageView *coordImageView;
/**地理位置名*/
@property (nonatomic,strong)UILabel *locationName;


+ (instancetype)ClockTableViewCellWithTableView:(UITableView *)tableview;
@end

NS_ASSUME_NONNULL_END
