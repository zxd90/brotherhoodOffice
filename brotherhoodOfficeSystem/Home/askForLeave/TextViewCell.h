//
//  TextViewCell.h
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/10.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PlaceholderTextView;
NS_ASSUME_NONNULL_BEGIN

@interface TextViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)PlaceholderTextView *textView;
@property(nonatomic,strong)NSString *string;
@end

NS_ASSUME_NONNULL_END
