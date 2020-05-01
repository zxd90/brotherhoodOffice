//
//  Homeheader.h
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/10.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Homeheader : UIView
@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,strong)UILabel *scopeLabel;
@property(nonatomic,strong)UILabel *locationLabel;
@property(nonatomic,strong)UIImageView *locationImage;
@property(nonatomic,strong)UIButton *workButton;
@property(nonatomic,strong)UILabel *timeLabel;
-(instancetype)initWithFrame:(CGRect)frame arr:(NSArray*)arr;
@end

NS_ASSUME_NONNULL_END
