//
//  requstTableViewCell.m
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/18.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "requstTableViewCell.h"
#import "requstModel.h"
@implementation requstTableViewCell
+ (instancetype)requstTableViewCellWithTableView:(UITableView *)tableview{
    requstTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:@"requstTableViewCell"];
    if(cell == nil){
        cell = [[requstTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"requstTableViewCell"];
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
 
    _labelName = [[UILabel alloc]initWithFrame:CGRectZero];
    _labelName.font = [UIFont systemFontOfSize:16];
     [self.contentView addSubview:self.labelName]; //姓名文字
    _matterName = [[UILabel alloc]initWithFrame:CGRectZero];
       _matterName.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.matterName];
    _labelroleName = [[UILabel alloc]initWithFrame:CGRectZero];
     _labelroleName.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.labelroleName];
    _timeName = [[UILabel alloc]initWithFrame:CGRectZero];
     _timeName.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.timeName];
}
- (void)setRequstModel:(requstModel *)requstModel{
     _requstModel = requstModel;
     [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:requstModel.headImg] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    self.labelName.text = requstModel.userName ;
    self.labelroleName.text = requstModel.roleName;
    self.matterName.text = requstModel.matterName;
    self.timeName.text=requstModel.createTime;
      CGFloat  width = [ZXDmethod calculateRowWidth:self.labelName.text Font:17.0];
    _labelName.frame =CGRectMake(_headerImageView.right+8,16,width, 20);
    _matterName.frame =CGRectMake(_labelName.right+8,16,ScreenW-_labelName.right-15, 20);
     CGFloat  rolewidth = [ZXDmethod calculateRowWidth:self.labelroleName.text Font:15.0];
    _labelroleName.frame = CGRectMake(_headerImageView.right+8,_labelName.bottom+8, rolewidth, 20);
    _timeName.frame = CGRectMake(_labelroleName.right+8,_labelName.bottom+8,ScreenW-_labelroleName.right-15, 20);
}
- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
