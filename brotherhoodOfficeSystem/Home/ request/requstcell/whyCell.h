//
//  whyCell.h
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/27.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface whyCell : UITableViewCell
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * rightLabel;
+ (instancetype)qtdetaTableViewCellWithTableView:(UITableView *)tableview;

@end

NS_ASSUME_NONNULL_END
