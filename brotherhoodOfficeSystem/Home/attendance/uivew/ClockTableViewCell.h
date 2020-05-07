//
//  ClockTableViewCell.h
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/28.
//  Copyright © 2020 兄弟团国际. All rights reserved.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class clockModel;
typedef void (^Signcolek)();
@interface ClockTableViewCell : UITableViewCell
/**圆点*/
@property (nonatomic,strong) UIView *roundView;
/**线*/
 @property (nonatomic,strong) UILabel *onLine;
/**线*/
 @property (nonatomic,strong) UILabel *downLine;
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
/**打卡按钮 */
@property (strong, nonatomic) UIButton *clockbutton;
/**时间状态*/
@property (nonatomic,strong)UILabel *clockstate;
/**当前时间*/
@property (nonatomic,strong)UILabel *clockTime;
/**地址名*/
@property (nonatomic,strong)UILabel *address;
/**重新定位*/
@property (nonatomic,strong)UIButton *positioning;
@property (nonatomic,strong)clockModel *cloModel;
@property(nonatomic,copy) Signcolek signcolek;
/**位置*/
@property (nonatomic,strong)NSString *addstr;
+ (instancetype)ClockTableViewCellWithTableView:(UITableView *)tableview;
@end
NS_ASSUME_NONNULL_END
