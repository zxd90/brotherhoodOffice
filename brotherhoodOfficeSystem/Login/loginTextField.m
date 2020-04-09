//
//  loginTextField.m
//  Business
//
//  Created by lcds on 2018/5/16.
//  Copyright © 2018年 lcds. All rights reserved.
//

#import "loginTextField.h"

@implementation loginTextField
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [RGBA(238, 238, 238, 1) set];//设置下划线颜色 这里是红色 可以自定义
    CGFloat y = CGRectGetHeight(self.frame);
    CGContextMoveToPoint(context, 0, y);
    CGContextAddLineToPoint(context, CGRectGetWidth(self.frame), y);
    //设置线的宽度
    CGContextSetLineWidth(context, 2);
    //渲染 显示到self上
    CGContextStrokePath(context);
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor

{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    dict[NSForegroundColorAttributeName] = placeholderColor;
    
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dict];
    
    [self setAttributedPlaceholder:attribute];
    
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont

{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = placeholderFont;
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dict];
    [self setAttributedPlaceholder:attribute];
}

@end
