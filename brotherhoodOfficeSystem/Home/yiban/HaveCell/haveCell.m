//
//  haveCell.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/18.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "haveCell.h"
#import "HaveModel.h"
@implementation haveCell
+ (instancetype)haveTableViewCellWithTableView:(UITableView *)tableview{
    haveCell *cell = [tableview dequeueReusableCellWithIdentifier:@"haveCell"];
    if(cell == nil){
        cell = [[haveCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"haveCell"];
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
    _headerImageView= [[UIImageView alloc]initWithFrame:CGRectMake(18, 18, 40, 40)];
    _headerImageView.layer.cornerRadius = 20;
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
- (void)setRequstModel:(HaveModel *)haveModel{
     _haveModel = haveModel;
     [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:haveModel.headImg] placeholderImage:[UIImage imageNamed:@""]];
    self.labelName.text = haveModel.userName ;
    self.labelroleName.text = haveModel.roleName;
    self.matterName.text = haveModel.matterName;
    self.timeName.text=haveModel.createTime;
      CGFloat  width = [ZXDmethod calculateRowWidth:self.labelName.text Font:17.0];
    _labelName.frame =CGRectMake(_headerImageView.right+8,16,width, 20);
    _matterName.frame =CGRectMake(_labelName.right+8,16,ScreenW-_labelName.right-15, 20);
     CGFloat  rolewidth = [ZXDmethod calculateRowWidth:self.labelroleName.text Font:15.0];
    _labelroleName.frame = CGRectMake(_headerImageView.right+8,_labelName.bottom+8, rolewidth, 20);
    _timeName.frame = CGRectMake(_labelroleName.right+8,_labelName.bottom+8,ScreenW-_labelroleName.right-15, 20);
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
