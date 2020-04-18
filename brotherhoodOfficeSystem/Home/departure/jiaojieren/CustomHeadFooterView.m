//
//  CustomHeadFooterView.m
//  核心动画
//
//  Created by 朱伟阁 on 2019/1/26.
//  Copyright © 2019 朱伟阁. All rights reserved.
//

#import "CustomHeadFooterView.h"
#import "GroupModel.h"

@interface CustomHeadFooterView ()

@property(nonatomic, strong) UIButton *btnGroupTitle;
@property(nonatomic, strong) UILabel *lblTitle;


@end

@implementation CustomHeadFooterView

+ (instancetype)headFooterViewWithTableview:(UITableView *)tableview{
    CustomHeadFooterView *view = [tableview dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([CustomHeadFooterView class])];
    if (view == nil) {
        view = [[CustomHeadFooterView alloc]initWithReuseIdentifier:NSStringFromClass([CustomHeadFooterView class])];
    }
    return view;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithReuseIdentifier:reuseIdentifier]){
        UIButton *btnGroupTitle = [UIButton buttonWithType:UIButtonTypeCustom];
       
        [btnGroupTitle setImage:[UIImage imageNamed:@"sanjiaoxing.png"] forState:UIControlStateNormal];
     
        [btnGroupTitle addTarget:self action:@selector(btnGroupTitleClickd:) forControlEvents:UIControlEventTouchUpInside];
           UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(notimageTap:)];
         [self addGestureRecognizer:tap];
        //设置按钮中图片的显示模式
        btnGroupTitle.contentMode = UIViewContentModeCenter;
        //设置图片超出的部分不要截掉
        btnGroupTitle.imageView.clipsToBounds = NO;
        [self.contentView addSubview:btnGroupTitle];
        self.btnGroupTitle = btnGroupTitle;
                 
        UILabel *lblTitle = [[UILabel alloc]init];
        [self.contentView addSubview:lblTitle];
        self.lblTitle = lblTitle;
    
    }
    return self;
}
-(void)notimageTap:(UITapGestureRecognizer *)sender{
    //设置组状态
       self.group.visible = !self.group.isVisible;
       if(self.delegate&&[self.delegate respondsToSelector:@selector(groupHeaderViewDidClickTitleButton:)]){
           [self.delegate groupHeaderViewDidClickTitleButton:self];
       }
}
- (void)btnGroupTitleClickd:(UIButton *)sender{
   
    //设置组状态
    self.group.visible = !self.group.isVisible;
    if(self.delegate&&[self.delegate respondsToSelector:@selector(groupHeaderViewDidClickTitleButton:)]){
        [self.delegate groupHeaderViewDidClickTitleButton:self];
    }
}

//当一个新的headerview已经加到某个父控件的时候调用
- (void)didMoveToSuperview{
    if(self.group.isVisible){
        self.btnGroupTitle.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{
        self.btnGroupTitle.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}

- (void)setGroup:(GroupModel *)group{
    //设置frame不要在这里设置frame，因为这个时候的当前控件(self)的宽和高都是0
    _group = group;
    self.lblTitle.text = [NSString stringWithFormat:@"%@(%d)",group.depName,group.total];
    if(self.group.isVisible){
        self.btnGroupTitle.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{
        self.btnGroupTitle.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}

//当前控件的frame发生改变的时候会调用这个方法
- (void)layoutSubviews{
    [super layoutSubviews];
 CGFloat  width = [ZXDmethod calculateRowWidth:self.lblTitle.text Font:17.0];
 self.btnGroupTitle.frame=CGRectMake(15,15, 14,14);
    [self.lblTitle setFrame:CGRectMake(self.btnGroupTitle.right+5,10,width, 24)];
}

@end
