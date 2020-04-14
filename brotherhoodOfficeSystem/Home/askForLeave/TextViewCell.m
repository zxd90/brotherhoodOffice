//
//  TextViewCell.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/10.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "TextViewCell.h"
@implementation TextViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
  
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     [self.contentView addSubview:self.titleLabel]; //标题文字
     [self autoLayout];
        
    }
    return self;
}
//布局
-(void)autoLayout{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
     make.left.mas_equalTo(self.contentView.mas_left).offset(16);
     make.top.mas_equalTo(self.contentView.mas_top).offset(10);
         make.height.mas_equalTo(20);
           }];
    self.textView = [[PlaceholderTextView alloc]init];
     self.textView.placeholderLabel.font = [UIFont systemFontOfSize:15];
    self.textView.backgroundColor= RGB(238, 238, 238);
    self.textView.frame = (CGRect){16,40,ScreenW-32,100};
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.maxLength = 100;
    self.textView.layer.cornerRadius = 5.f;
    self.textView.layer.borderColor = [[UIColor grayColor]colorWithAlphaComponent:0.3].CGColor;
     self.textView.layer.borderWidth = 0.5f;
    [self.contentView addSubview:self.textView];
}
#pragma mark--懒加载
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:16];
       
    }
    return _titleLabel ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
