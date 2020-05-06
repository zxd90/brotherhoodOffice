//
//  RecordClockCell.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/5/6.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "RecordClockCell.h"
#import "clockModel.h"
@implementation RecordClockCell
+ (instancetype)RecordClockTableViewCellWithTableView:(UITableView *)tableview{
    RecordClockCell *cell = [tableview dequeueReusableCellWithIdentifier:@"ClockTableViewCell"];
    if(cell == nil){
        cell = [[RecordClockCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ClockTableViewCell"];
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
        make.top.mas_equalTo(self.mas_top).offset(18);
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
        make.width.mas_equalTo(@1);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    _timelabel = [[UILabel alloc]init];
    _timelabel.textColor = RGB(145,145, 145);
    _timelabel.font =PFR15Font;
    [self.contentView addSubview:_timelabel];
    [_timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(14.0);
        make.left.mas_equalTo(self.roundView.mas_right).offset(5);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(20);
    }];
    _clockLabel = [[UILabel alloc]init];
    _clockLabel.font =[UIFont fontWithName:@"Helvetica-Bold"size:18];
    _clockLabel.textColor = RGB(28,27, 32);
    [self.contentView addSubview:_clockLabel];
   [_clockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timelabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.roundView.mas_right).offset(5);
               make.width.mas_equalTo(120);
               make.height.mas_equalTo(20);
           }];
    _coordImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_coordImageView];
    [_coordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.clockLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.roundView.mas_right).offset(5);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    _locationName = [[UILabel alloc]init];
    _locationName.textColor = RGB(145,145, 145);
    _locationName.font =PFR15Font;
    [self.contentView addSubview:_locationName];
    [_locationName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.clockLabel.mas_bottom).offset(15);
            make.left.mas_equalTo(self.coordImageView.mas_right).offset(5);
            make.width.mas_equalTo(200);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
        }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}
/**获取数据*/
-(void)setCloModel:(clockModel *)cloModel{
    _cloModel= cloModel;
     if(cloModel.clockFlag ==true){
        _clockLabel.text=[NSString stringWithFormat:@"打卡时间%@",_cloModel.clockTime];
         [self tagsCloModel:_cloModel];
        _locationName.text=[NSString stringWithFormat:@"%@",_cloModel.clockAddr];
        _coordImageView.image=[UIImage imageNamed:@"dingwei"];
     }else{
         [self tagsCloModel:_cloModel];
     }
}
-(void)tagsCloModel:(clockModel *)cloModel{
    
    [_statelabel removeFromSuperview];
    for (int i=0; cloModel.tags.count>i; i++){
               _statelabel = [[UILabel alloc]initWithFrame:CGRectMake(150+i*45,14, 40, 20)];
               _statelabel.font =PFR14Font;
               _statelabel.text = cloModel.tags[i];
               _statelabel.textColor = [UIColor whiteColor];
               _statelabel.layer.masksToBounds = YES;
               _statelabel.layer.cornerRadius = 3;
               _statelabel.textAlignment =NSTextAlignmentCenter;
               [self.contentView addSubview:_statelabel];
             if ([cloModel.tags[i] isEqualToString:@"正常"]) {
            _statelabel.backgroundColor= RGB(13, 163, 38);
             }else if ([cloModel.tags[i] isEqualToString:@"迟到"]){
             _statelabel.backgroundColor= [UIColor redColor];
            }else if ([cloModel.tags[i] isEqualToString:@"外勤"]){
             _statelabel.backgroundColor= [UIColor orangeColor];
            }else if ([cloModel.tags[i] isEqualToString:@"缺卡"]){
             _statelabel.backgroundColor= [UIColor grayColor];
            }else if ([cloModel.tags[i] isEqualToString:@"早退"]){
             _statelabel.backgroundColor= [UIColor redColor];
            }
        }
}
@end
