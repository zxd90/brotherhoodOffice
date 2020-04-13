//
//  inductionCell.m
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/11.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "inductionCell.h"

@implementation inductionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
  
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

       [self.contentView addSubview:self.titleLabel]; //标题文字
//     [self addSubview:self.rightImg] ; //右侧箭头
       [self.contentView addSubview:self.textField]; //右侧扩展说明内容
  
        
    }
    return self;
}
//布局
-(void)layoutSubviews{
[super layoutSubviews];
    //计算文字的宽度

  CGFloat  width = [ZXDmethod calculateRowWidth:self.titleLabel.text Font:17.0];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(16);
      make.top.mas_equalTo(self.contentView.mas_centerY).offset(-10);
      make.height.mas_equalTo(20);
        make.width.mas_equalTo(width);
           }];
      [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
      
       make.left.mas_equalTo(self.titleLabel.mas_right).offset(5);
       make.top.mas_equalTo(self.contentView.mas_centerY).offset(-10);
       make.height.mas_equalTo(20);
      
          }];
}
#pragma mark--懒加载
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.numberOfLines = 1;
         _titleLabel.font = [UIFont systemFontOfSize:16.0];
    }
    return _titleLabel ;
}

-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectZero];
        _textField.font = [UIFont systemFontOfSize:15];
        
       
    }
    return _textField ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
