//
//  timeLineCell.h
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/12.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "timeLineModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface timeLineCell : UITableViewCell
 ///时间线
@property (nonatomic, strong) UIView *timeLine;

 ///时间线上的小圆点
@property (nonatomic, strong) UIView *cirlePoint;
 ///时间
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) timeLineModel *model;
@end

NS_ASSUME_NONNULL_END
