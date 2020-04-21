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
    //未用此文件
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
  
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

       [self.contentView addSubview:self.titleLabel]; //标题文字
//     [self addSubview:self.rightImg] ; //右侧箭头
       [self.contentView addSubview:self.textField]; //右侧扩展说明内容
        
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right.png"]];
      
        
    }
    return self;
}
//布局
-(void)layoutSubviews{
[super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(self.contentView.mas_left).offset(16);
   make.top.mas_equalTo(self.contentView.mas_centerY).offset(-10);
       make.height.mas_equalTo(20);
         }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
    
     make.right.mas_equalTo(self.contentView.mas_right);
     make.top.mas_equalTo(self.contentView.mas_centerY).offset(-10);
     make.height.mas_equalTo(20);
    
        }];
}
#pragma mark--懒加载
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:16];
       
    }
    return _titleLabel ;
}

-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectZero];
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.placeholder =@"请选择";
   
    }
    return _textField ;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
