//
//  todoTableViewCell.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/16.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "todoTableViewCell.h"

@implementation todoTableViewCell
+ (instancetype)friendTableViewCellWithTableView:(UITableView *)tableview{
    todoTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:@"todoTableViewCell"];
    if(cell == nil){
        cell = [[todoTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"todoTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}
//布局
-(void)setUI{
    _headerImageView= [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 40, 40)];
    _headerImageView.layer.cornerRadius = 20;
    _headerImageView.layer.masksToBounds = YES;
    //右侧扩展说明内容
    [self.contentView addSubview:self.headerImageView];
    _labelName = [[UILabel alloc]initWithFrame:CGRectMake(_headerImageView.right+8,6, 200, 20)];
    _labelName.font = [UIFont systemFontOfSize:16];
 
     [self.contentView addSubview:self.labelName]; //标题文字
    _labelroleName = [[UILabel alloc]initWithFrame:CGRectMake(_headerImageView.right+8,_labelName.bottom+4, 200, 20)];
     _labelroleName.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.labelroleName];
}
//- (void)setFriendModel:(FriendModel *)friendModel{
//    _friendModel = friendModel;
//    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:friendModel.headImg] placeholderImage:[UIImage imageNamed:@""]];
//    self.labelName.text = friendModel.userName ;
//    self.labelroleName.text = friendModel.roleName;
//   self.detailTextLabel.textColor = [UIColor blackColor];
//}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
