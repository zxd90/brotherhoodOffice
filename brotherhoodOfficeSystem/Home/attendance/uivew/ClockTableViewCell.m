//
//  ClockTableViewCell.m
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/28.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "ClockTableViewCell.h"

@implementation ClockTableViewCell
+ (instancetype)ClockTableViewCellWithTableView:(UITableView *)tableview{
    ClockTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:@"ClockTableViewCell"];
                      cell.separatorInset = UIEdgeInsetsMake(0,ScreenW, 0, 0);
       if(cell == nil){
           cell = [[ClockTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ClockTableViewCell"];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
       }
       return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutSubview];
    }
    return self;
}

-(void)layoutSubview{
    self.roundView = [[UIView alloc]init];
             self.roundView.backgroundColor = RGB(13, 163, 38);
             self.roundView.layer.masksToBounds = YES;
             self.roundView.layer.cornerRadius = 6;
//             self.roundView.layer.borderWidth = 1;
//             self.roundView.layer.borderColor = [RGB(13, 163, 38) CGColor];
             [self.contentView addSubview:self.roundView];
             [self.roundView mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.top.mas_equalTo(self.mas_top).offset(28);
                 make.left.mas_equalTo(self.mas_left).offset(18);
                 make.size.mas_equalTo(CGSizeMake(12, 12));
             }];
             _onLine = [[UILabel alloc]init];
             _onLine.backgroundColor = RGB(145,145, 145);
             [self.contentView addSubview:_onLine];
             [_onLine mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.mas_equalTo(self.mas_left).offset(23.5);
                 //make.size.mas_equalTo(CGSizeMake(1, 15));
                 make.top.mas_equalTo(self.mas_top);
                 make.bottom.mas_equalTo(self.roundView.mas_top);
                 make.width.mas_equalTo(@1);
             }];
             _downLine = [[UILabel alloc]init];
             _downLine.backgroundColor = RGB(145,145, 145);
             [self.contentView addSubview:_downLine];
             [_downLine mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.top.mas_equalTo(self.roundView.mas_bottom);
                 make.left.mas_equalTo(self.mas_left).offset(23.5);
                 make.bottom.mas_equalTo(self.mas_bottom);
                 make.width.mas_equalTo(@1);
             }];
            _timelabel = [[UILabel alloc]init];
            _timelabel.textColor = RGB(145,145, 145);
            [self.contentView addSubview:_timelabel];
            [_timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.roundView.mas_centerY);
                make.left.mas_equalTo(self.roundView.mas_left).offset(5);
                make.width.mas_equalTo(20);
            }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
