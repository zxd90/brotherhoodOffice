//
//  Homeheader.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/10.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "Homeheader.h"
@interface Homeheader(){
     dispatch_source_t _timer;
}
@end
@implementation Homeheader
-(instancetype)initWithFrame:(CGRect)frame str:(NSString*)str
{
   
    if (self = [super initWithFrame:frame]) {
            
      
      
        [self autoLayout:str];
    }
    return self;
}
//布局
-(void)autoLayout:(NSString*)string{

      CAGradientLayer *gradientLayer = [CAGradientLayer layer];
      gradientLayer.frame = self.frame;
       gradientLayer.colors = @[(id)RGBA(55, 145, 240, 1).CGColor,(id)RGBA(47, 109, 224, 1).CGColor];  // 设置渐变颜色
       gradientLayer.locations = @[@0.0,@0.7];    // 颜色的起点位置，递增，并且数量跟颜色数量相等
       gradientLayer.startPoint = CGPointMake(0.3, 0);   //
       gradientLayer.endPoint = CGPointMake(0.5, 1);
       [self.layer addSublayer:gradientLayer];
    
        _scopeLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2-75,self.top+33, 150, 20)];
        _scopeLabel.textColor =[UIColor whiteColor];
        _scopeLabel.font = [UIFont systemFontOfSize:15];
        _scopeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _scopeLabel.textAlignment = NSTextAlignmentCenter;
         
     _workButton= [[UIButton alloc] initWithFrame:CGRectMake(ScreenW/2-50,_scopeLabel.bottom+10,100, 100)];
    
      [_workButton setBackgroundImage:[UIImage imageNamed:@"shouyedaka"] forState:UIControlStateNormal];
      [_workButton addTarget:self action:@selector(workButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 50, 70,20)];
    _timeLabel.font=PFR14Font;
    _locationLabel = [[UILabel alloc]init];  self.locationLabel.text=string;
    CGFloat  width = [ZXDmethod calculateRowWidth:self.locationLabel.text Font:15];
    _locationLabel.frame=CGRectMake((ScreenW-width)/2, self.workButton.bottom+13,width, 20);
    _locationLabel.preferredMaxLayoutWidth = ScreenW-93;
    self.locationLabel.numberOfLines = 1;
         _locationLabel.textColor =[UIColor whiteColor];
         _locationLabel.font = [UIFont systemFontOfSize:15];
         _locationLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _locationImage= [[UIImageView alloc] initWithFrame:CGRectMake(self.locationLabel.right+3, self.locationLabel.top, 20, 20)];
    [_locationImage setImage:[UIImage imageNamed:@"shouyeshuaxin"]];
       _locationImage.userInteractionEnabled = YES;
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(locationButtonClick:)];
     [_locationImage addGestureRecognizer:tap];
 
          [self addSubview:_workButton];
          [_workButton addSubview:_timeLabel];
          [self addSubview:_scopeLabel];
          [self addSubview:_locationLabel];
          [self addSubview:_locationImage];
    [self countdownAnd];
}
-(void)locationButtonClick:(UITapGestureRecognizer*)changeBtn{
     if(![_locationImage.layer animationForKey:@"rotatianAnimKey"]){
    [ZXDmethod rotate360DegreeWithImageView:_locationImage];
     }

}

-(void)workButtonClick{
    [_locationImage.layer removeAllAnimations];
}
/**当前时间显示*/
-(void)countdownAnd{
     __weak __typeof(self) weakSelf = self;
    if (_timer==nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
         dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            NSLog(@"%@", [self getHhmmss]);
            dispatch_async(dispatch_get_main_queue(), ^{
            
                    self.timeLabel.text=[weakSelf getHhmmss];
                });
           
            });
            dispatch_resume(_timer);
    }
}
/**
 *  获取当天的年月日的字符串
 *  这里测试用
 *  @return 格式为年-月-日
 */
-(NSString *)getyyyymmdd{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyy-MM-dd";
    NSString *dayStr = [formatDay stringFromDate:now];
    return dayStr;
    
}
/**
 *  获取当天的年月日的字符串
 *  这里测试用
 *  @return 格式为时-分-秒
 */
-(NSString *)getHhmmss{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"HH:mm:ss";
    NSString *dayStr = [formatDay stringFromDate:now];
    return dayStr;
    
}
@end
