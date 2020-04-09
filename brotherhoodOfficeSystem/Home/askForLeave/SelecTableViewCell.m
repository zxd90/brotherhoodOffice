//
//  SelecTableViewCell.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/8.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "SelecTableViewCell.h"

@implementation SelecTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

       [self.contentView addSubview:self.titleLabel]; //标题文字
//       [self addSubview:self.rightImg] ; //右侧箭头
       [self.contentView addSubview:self.TextField]; //右侧扩展说明内容
    }
    return self;
}
//布局
-(void)layoutSubviews{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(self.contentView.mas_left).offset(16);
       make.top.mas_equalTo(self.contentView.mas_top).offset(8);
       make.height.mas_equalTo(20);
         }];
     [self.TextField mas_makeConstraints:^(MASConstraintMaker *make) {
     make.top.mas_equalTo(self.contentView.mas_top).offset(16);
make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
     make.height.mas_equalTo(20);
    
        }];
}
#pragma mark--懒加载
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text =@"请假类型";
    }
    return _titleLabel ;
}

-(UITextField *)rightExtendLabel{
    if (!_TextField) {
        _TextField = [[UITextField alloc]initWithFrame:CGRectZero];
        _TextField.font = [UIFont systemFontOfSize:14];
        _TextField.placeholder =@"请输入";
    }
    return _TextField ;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
