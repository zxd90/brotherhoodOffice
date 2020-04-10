//
//  Homeheader.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/10.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "Homeheader.h"
static int angle =0;
@implementation Homeheader
-(instancetype)initWithFrame:(CGRect)frame
{
   
    if (self = [super initWithFrame:frame]) {
            
             [self autoLayout];
    }
    return self;
}
-(void)autoLayout
{
      CAGradientLayer *gradientLayer = [CAGradientLayer layer];
      gradientLayer.frame = self.frame;
       gradientLayer.colors = @[(id)RGBA(55, 145, 240, 1).CGColor,(id)RGBA(47, 109, 224, 1).CGColor];  // 设置渐变颜色
       gradientLayer.locations = @[@0.0,@0.7];    // 颜色的起点位置，递增，并且数量跟颜色数量相等
       gradientLayer.startPoint = CGPointMake(0.3, 0);   //
       gradientLayer.endPoint = CGPointMake(0.5, 1);
       [self.layer addSublayer:gradientLayer];
        _scopeLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2-75,self.top+33, 150, 20)];
        _scopeLabel.textColor =[UIColor whiteColor];
        _scopeLabel.font = [UIFont systemFontOfSize:14];
        _scopeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _scopeLabel.textAlignment = NSTextAlignmentCenter;
         [self addSubview:_scopeLabel];
     _workButton= [[UIButton alloc] initWithFrame:CGRectMake(ScreenW/2-50,_scopeLabel.bottom+10,100, 100)];
      [_workButton setBackgroundImage:[UIImage imageNamed:@"shouyedaka"] forState:UIControlStateNormal];
          
      [_workButton addTarget:self action:@selector(workButtonClick) forControlEvents:UIControlEventTouchUpInside];
           [self addSubview:_workButton];
 
    _locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, self.workButton.bottom+13,ScreenW-93, 20)];
   
    self.locationLabel.preferredMaxLayoutWidth = ScreenW-93;

    self.locationLabel.numberOfLines = 0;
         _locationLabel.textColor =[UIColor whiteColor];
         _locationLabel.font = [UIFont systemFontOfSize:14];
         _locationLabel.lineBreakMode = NSLineBreakByTruncatingTail;
          [self addSubview:_locationLabel];
    _locationImage= [[UIImageView alloc] initWithFrame:CGRectMake(self.locationLabel.right+3, self.locationLabel.top, 20, 20)];
    [_locationImage setImage:[UIImage imageNamed:@"shouyeshuaxin"]];
       _locationImage.userInteractionEnabled = YES;
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(locationButtonClick:)];
     [_locationImage addGestureRecognizer:tap];
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
