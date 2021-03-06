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
     cell.separatorInset = UIEdgeInsetsMake(0,15, 0, 15);
    if(cell == nil){
        cell = [[qtdetaCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"qtdetaCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    [self configureView];
    }
    return self;
}

//布局
-(void)configureView{
 
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
         _titleLabel.font = [UIFont systemFontOfSize:16];
          [self.contentView addSubview:self.titleLabel]; //标题文字
    _rightLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _rightLabel.font = [UIFont systemFontOfSize:15] ;
    _rightLabel.numberOfLines=0;
     self.rightLabel.textAlignment =NSTextAlignmentRight;
        [self.contentView addSubview:self.rightLabel]; //右侧扩展说明内容
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
     make.left.mas_equalTo(self.contentView.mas_left).offset(15);
     make.top.mas_equalTo(self.contentView.mas_top).offset(15);
     make.height.mas_equalTo(20);
       }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         
    make.top.mas_equalTo(self.contentView.mas_top).offset(15);
    make.left.mas_equalTo(self.titleLabel.mas_right).offset(10);
    make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
     // 步骤5：设置评论的bottom与contentView.mas_bottom之间的约束
    make.bottom.equalTo(self.contentView.mas_bottom).offset(-15.0);
    }];
 
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
