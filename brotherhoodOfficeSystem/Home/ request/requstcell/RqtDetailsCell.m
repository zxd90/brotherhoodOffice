//
//  RqtDetailsCell.m
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/18.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "RqtDetailsCell.h"
#import "rqtDetModel.h"
@implementation RqtDetailsCell
+ (instancetype)rqtDetTableViewCellWithTableView:(UITableView *)tableview{
    RqtDetailsCell *cell = [tableview dequeueReusableCellWithIdentifier:@"RqtDetailsCell"];
       if(cell == nil){
           cell = [[RqtDetailsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"RqtDetailsCell"];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
       }
       return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
    }
    return self;
}
- (void)initSubViews {
    self.roundView = [[UIView alloc]init];
           self.roundView.backgroundColor = [UIColor blueColor];
           self.roundView.layer.masksToBounds = YES;
           self.roundView.layer.cornerRadius = 12;
           self.roundView.layer.borderWidth = 1;
           [self.contentView addSubview:self.roundView];
           [self.roundView mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.mas_equalTo(self.mas_top).offset(28);
               make.left.mas_equalTo(self.mas_left).offset(15);
               make.size.mas_equalTo(CGSizeMake(24, 24));
           }];
           _onLine = [[UILabel alloc]init];
           _onLine.backgroundColor = [UIColor blackColor];
           [self.contentView addSubview:_onLine];
           [_onLine mas_makeConstraints:^(MASConstraintMaker *make) {
               make.left.mas_equalTo(self.mas_left).offset(27);
               make.size.mas_equalTo(CGSizeMake(1, 15));
           }];

           _downLine = [[UILabel alloc]init];
           _downLine.backgroundColor = [UIColor blackColor];
           [self.contentView addSubview:_downLine];
           [_downLine mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.mas_equalTo(self.roundView.mas_bottom);
               make.left.mas_equalTo(self.mas_left).offset(27);
               make.bottom.mas_equalTo(self.mas_bottom);
               make.width.mas_equalTo(@1);
           }];
       _headerImageView= [[UIImageView alloc]init];
       _headerImageView.layer.cornerRadius = 20;
       _headerImageView.layer.masksToBounds = YES;
    //右侧扩展说明内容
     [self.contentView addSubview:self.headerImageView];
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(18);
        make.left.mas_equalTo(self.roundView.mas_right).offset(10);
                 make.height.mas_equalTo(40);
                 make.width.mas_equalTo(40);
             }];
      
    
       _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
       _titleLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.titleLabel]; //姓名文字
       _matterName = [[UILabel alloc]initWithFrame:CGRectZero];
          _matterName.font = [UIFont systemFontOfSize:16];
           [self.contentView addSubview:self.matterName];
       _contentlabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _contentlabel.font = [UIFont systemFontOfSize:14];
       [self.contentView addSubview:self.contentlabel];
       _timelabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _timelabel.font = [UIFont systemFontOfSize:14];
       [self.contentView addSubview:self.timelabel];
       _Proces = [[UILabel alloc]initWithFrame:CGRectZero];
           _Proces.font = [UIFont systemFontOfSize:14];
          [self.contentView addSubview:self.Proces];
}


- (void)setModel:(rqtDetModel *)model {
    
    _model = model;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.headImg] placeholderImage:[UIImage imageNamed:@""]];
      self.titleLabel.text = model.userName ;
      self.contentlabel.text = model.roleName;
      self.matterName.text = model.isCheck ;
      self.timelabel.text=model.checkTime;
        CGFloat  width = [ZXDmethod calculateRowWidth:self.titleLabel.text Font:17.0];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerImageView.mas_top).offset(-2);
           make.left.mas_equalTo(self.headerImageView.mas_right).offset(8);
                    make.height.mas_equalTo(20);
                    make.width.mas_equalTo(width);
    }];
    [_matterName mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(self.headerImageView.mas_top).offset(-2);
            make.left.mas_equalTo(self.titleLabel.mas_right).offset(8);
                     make.height.mas_equalTo(20);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
     }];
   
       CGFloat  rolewidth = [ZXDmethod calculateRowWidth:self.contentlabel.text Font:15.0];
    [_contentlabel mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(8);
             make.left.mas_equalTo(self.headerImageView.mas_right).offset(8);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(rolewidth);
      }];
      [_timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(8);
         make.left.mas_equalTo(self.contentlabel.mas_right).offset(8);
                      make.height.mas_equalTo(20);
         make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
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
