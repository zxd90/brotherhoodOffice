//
//  ZXDmethod.h
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/10.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXDmethod : NSObject
//计算文字宽度
+(CGFloat)calculateRowWidth:(NSString *)string Font:(CGFloat)font;
+(UIImage *)ButtonColorLayer;
+(UIImage *)loginColorLayer;
+ (void)rotate360DegreeWithImageView:(UIImageView *)imageView;
@end

NS_ASSUME_NONNULL_END
