//
//  ClockTableViewCell.m
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/28.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "ClockTableViewCell.h"
#import "clockModel.h"
@interface ClockTableViewCell(){
    dispatch_source_t _timer;
    CGFloat  addreewidth;
}
@end
@implementation ClockTableViewCell
+ (instancetype)ClockTableViewCellWithTableView:(UITableView *)tableview{
    ClockTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:@"ClockTableViewCell"];
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
        for (int i=0; cloModel.tags.count>i; i++) {
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
        _locationName.text=[NSString stringWithFormat:@"%@",_cloModel.clockAddr];
        _coordImageView.image=[UIImage imageNamed:@"dingwei"];
    }
    
    if (cloModel.buttonFlag==true){
        _address =[[UILabel alloc]init];
        _address.textColor = RGB(145,145, 145);
        _address.font =PFR15Font;
        _address.textAlignment =NSTextAlignmentRight;
        [self.contentView addSubview:_address];
        _clockbutton=[UIButton buttonWithType:UIButtonTypeSystem];
        [_clockbutton addTarget:self action:@selector(SigninToClock) forControlEvents:UIControlEventTouchUpInside];
        _clockbutton.layer.masksToBounds = YES;
        _clockbutton.layer.cornerRadius = 60;
        [self.contentView addSubview:_clockbutton];
        if ( [cloModel.clockAddr isEqualToString:@"外勤"]) {
                [_clockbutton setBackgroundColor:[UIColor orangeColor]];
                  _address.text =[NSString stringWithFormat:@"当前%@", self.addstr];
           
                }else{
                    [_clockbutton setBackgroundImage:[ZXDmethod ButtonColorLayer] forState:UIControlStateNormal];
                   _address.text = cloModel.clockAddr;
               }
         CGFloat  width = [ZXDmethod calculateRowWidth:self.address.text Font:15];
        if (width>ScreenW-190) {
            addreewidth=ScreenW-190;
        }else{
            addreewidth=width;
        }
        [_clockbutton mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.mas_equalTo(self.contentView.mas_top).offset(39);
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(120);
        }];
        _clockstate =[[UILabel alloc]init];
        _clockstate.font =[UIFont boldSystemFontOfSize:18];
        _clockstate.textAlignment =NSTextAlignmentCenter;
        _clockstate.text=@"上班打卡";
        _clockstate.textColor = [UIColor whiteColor];
        [_clockbutton addSubview:_clockstate];
        [_clockstate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.clockbutton.mas_centerY).offset(-20);
            make.centerX.mas_equalTo(self.clockbutton.mas_centerX);
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(20);
        }];
        _clockTime =[[UILabel alloc]init];
        _clockTime.font =PFR15Font;
        _clockTime.textAlignment =NSTextAlignmentCenter;
        _clockTime.textColor = [UIColor whiteColor];
        [_clockbutton addSubview:_clockTime];
        [_clockTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.clockbutton.mas_centerY).offset(10);
            make.centerX.mas_equalTo(self.clockbutton.mas_centerX);
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(20);
        }];
        _positioning=[[UIButton alloc]init];
              _positioning.titleLabel.font=PFR15Font;
              [_positioning setTitle:@"重新定位" forState:UIControlStateNormal];
              [_positioning setTitleColor:RGB(108, 197, 95) forState:UIControlStateNormal];
              [self.contentView  addSubview:_positioning];
        [_positioning mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.clockbutton.mas_bottom).offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-60);
        make.width.mas_equalTo(60);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
              }];
        
       
        [_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.clockbutton.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
        make.right.mas_equalTo(self.positioning.mas_left).offset(-5);
        make.width.mas_equalTo(self->addreewidth);
        }];
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image=[UIImage imageNamed:@"dingwei"];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.address.mas_left).offset(-2);
            make.centerY.mas_equalTo(self.address.mas_centerY);
            make.width.mas_equalTo(20);
        }];
        [self countdownAnd];
    }
}
-(void)SigninToClock{
    self.signcolek();
}
/**当前时间显示*/
-(void)countdownAnd{
    __weak __typeof(self) weakSelf = self;
    if (_timer==nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.clockTime.text=[YearsTime getHhmmss];
            });
        });
        dispatch_resume(_timer);
    }
}

@end
