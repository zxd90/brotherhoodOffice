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
 ///时间线
@property (nonatomic, strong) UIView *timeLine;

 ///时间线上的小圆点
@property (nonatomic, strong) UIView *cirlePoint;
 ///时间
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) rqtDetModel *model;
@end

NS_ASSUME_NONNULL_END
