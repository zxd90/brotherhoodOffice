//
//  Homeheader.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/10.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "Homeheader.h"
@interface Homeheader()<SDCycleScrollViewDelegate>
@end
@implementation Homeheader
-(instancetype)initWithFrame:(CGRect)frame arr:(NSArray*)arr
{
   
    if (self = [super initWithFrame:frame]) {
        _arr=arr;
      [self layoutSubview];
    }
    return self;
}
-(void)layoutSubview{
          SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,4, ScreenW, (ScreenH - SK_TabbarHeight) / 327 * 80+20) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
          cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
          cycleScrollView.delegate = self;
          cycleScrollView.imageURLStringsGroup =self.arr;
          //几秒轮播
          cycleScrollView.autoScrollTimeInterval = 3;
          cycleScrollView.currentPageDotColor = RGB(13, 163, 38);
          cycleScrollView.pageDotColor = [UIColor whiteColor];
          cycleScrollView.layer.masksToBounds = YES;
         //圆角
          cycleScrollView.layer.cornerRadius = 0;
          [self addSubview:cycleScrollView];
}
 
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}
- (NSArray *)arr {
    if (!_arr) {
       _arr = [NSArray array];
    }
    return _arr;
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
    
}
-(void)locationButtonClick:(UITapGestureRecognizer*)changeBtn{
     if(![_locationImage.layer animationForKey:@"rotatianAnimKey"]){
    [ZXDmethod rotate360DegreeWithImageView:_locationImage];
     }

}

-(void)workButtonClick{
    [_locationImage.layer removeAllAnimations];
}

@end
