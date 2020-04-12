//
//  ZXDmethod.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/10.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "ZXDmethod.h"

@implementation ZXDmethod
//设置渐变颜色
+(UIImage *)ButtonColorLayer{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(20, 0, ScreenW-40, 50);  // 设置显示的frame
    gradientLayer.colors = @[(id)RGBA(66, 153, 16, 1).CGColor,(id)RGBA(13, 163, 38, 1).CGColor];  // 设置渐变颜色
    gradientLayer.locations = @[@0.0,@0.7];    // 颜色的起点位置，递增，并且数量跟颜色数量相等
    gradientLayer.startPoint = CGPointMake(0, 0);   //
    gradientLayer.endPoint = CGPointMake(1, 0);
    UIGraphicsBeginImageContext(gradientLayer.frame.size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}
+(UIImage *)loginColorLayer{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(20, 0, ScreenW-40, 50);  // 设置显示的frame
    gradientLayer.colors = @[(id)RGBA(66, 153, 16, 1).CGColor,(id)RGBA(78, 195, 11, 1).CGColor];  // 设置渐变颜色
    gradientLayer.locations = @[@0.0,@0.4];    // 颜色的起点位置，递增，并且数量跟颜色数量相等
    gradientLayer.startPoint = CGPointMake(0, 0);   //
    gradientLayer.endPoint = CGPointMake(1, 0);
    UIGraphicsBeginImageContext(gradientLayer.frame.size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

+ (void)rotate360DegreeWithImageView:(UIImageView *)imageView{
  

        CABasicAnimation *rotationAnimation;

        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];

        rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];

        rotationAnimation.duration = 1;

        rotationAnimation.repeatCount = HUGE_VALF;

        [imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];

    
}
//计算文字宽度
+(CGFloat)calculateRowWidth:(NSString *)string Font:(CGFloat)font {

NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};

CGRect rect = [string boundingRectWithSize:CGSizeMake(0, 30)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |
NSStringDrawingUsesFontLeading attributes:dic context:nil];

return rect.size.width;

}
@end
