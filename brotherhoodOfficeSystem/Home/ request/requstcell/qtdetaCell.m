//
//  qtdetaCell.m
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/18.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "qtdetaCell.h"

@implementation qtdetaCell
+ (instancetype)qtdetaTableViewCellWithTableView:(UITableView *)tableview{
    qtdetaCell *cell = [tableview dequeueReusableCellWithIdentifier:@"qtdetaCell"];
    if(cell == nil){
        cell = [[qtdetaCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"qtdetaCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       [self.contentView addSubview:self.titleLabel]; //标题文字
       [self.contentView addSubview:self.rightLabel]; //右侧扩展说明内容
    
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
   [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
  
   make.top.mas_equalTo(self.contentView.mas_top).offset(16);
 make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
   make.height.mas_equalTo(20);
  
      }];
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:16];
      
    }
    return _titleLabel ;
}
-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _rightLabel.font = [UIFont systemFontOfSize:15] ;
    
    }
    return _rightLabel ;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end