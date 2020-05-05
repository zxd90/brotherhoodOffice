//
//  FriendTableViewCell.m
//  核心动画
//
//  Created by 朱伟阁 on 2019/1/27.
//  Copyright © 2019 朱伟阁. All rights reserved.
//

#import "FriendTableViewCell.h"
#import "FriendModel.h"

@implementation FriendTableViewCell

+ (instancetype)friendTableViewCellWithTableView:(UITableView *)tableview{
    FriendTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:@"FriendTableViewCell"];
    if(cell == nil){
        cell = [[FriendTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"FriendTableViewCell"];
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
    _headerImageView= [[UIImageView alloc]initWithFrame:CGRectMake(18, 13, 50, 50)];
    _headerImageView.layer.cornerRadius = 25;
    _headerImageView.layer.masksToBounds = YES;
    //右侧扩展说明内容
    [self.contentView addSubview:self.headerImageView];
    _labelName = [[UILabel alloc]initWithFrame:CGRectMake(_headerImageView.right+8,16, 200, 20)];
    _labelName.font = [UIFont systemFontOfSize:16];
 
     [self.contentView addSubview:self.labelName]; //标题文字
    _labelroleName = [[UILabel alloc]initWithFrame:CGRectMake(_headerImageView.right+8,_labelName.bottom+8, 200, 20)];
     _labelroleName.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.labelroleName];
}
- (void)setFriendModel:(FriendModel *)friendModel{
    _friendModel = friendModel;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:friendModel.headImg] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    self.labelName.text = friendModel.userName ;
    self.labelroleName.text = friendModel.roleName;
   self.detailTextLabel.textColor = [UIColor blackColor];
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
