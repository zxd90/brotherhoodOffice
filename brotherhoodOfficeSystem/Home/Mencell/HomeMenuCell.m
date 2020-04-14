//
//  HomeMenuCell.m
//  meituan
//
//  Created by lujh on 15/6/30.
//  Copyright (c) 2015年 lujh. All rights reserved.
//
// 4.屏幕大小尺寸
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
// 2.获得RGB颜色
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)                        RGBA(r, g, b, 1.0f)
#define navigationBarColor RGB(33, 192, 174)

#import "HomeMenuCell.h"
@interface HomeMenuCell ()<UIScrollViewDelegate>

@end

@implementation HomeMenuCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier menuArray:(NSMutableArray *)menuArray{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.menuArray = [NSMutableArray array];
        
        self.menuArray = menuArray;
        
        // 初始化cell布局
        [self setUpSubViews];
        
    }
    return self;
}

#pragma mark -初始化cell布局

- (void)setUpSubViews {

    // 轮播图第一页
    _backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 160)];
    
    // 轮播图第二页
    _backView2 = [[UIView alloc] initWithFrame:CGRectMake(screen_width, 0, screen_width, 160)];
    
    // UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 175)];
    scrollView.contentSize = CGSizeMake(2*screen_width, 175);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    [scrollView addSubview:_backView1];
    [scrollView addSubview:_backView2];
    [self addSubview:scrollView];
    
    //创建8个view
    for (int i = 0; i < _menuArray.count; i++) {
        if (i < 5) {
            CGRect frame = CGRectMake(i*(screen_width-36)/5+18, 0, (screen_width-36)/5, 80);
            NSString *title = [_menuArray[i] objectForKey:@"title"];
            NSString *imageStr = [_menuArray[i] objectForKey:@"image"];
            JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
            btnView.tag = 10+i;
            [_backView1 addSubview:btnView];
            
            // 点击手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOneView:)];
            [btnView addGestureRecognizer:tap];
            
        }else if(i<10){
            CGRect frame = CGRectMake((i-5)*(screen_width-36)/5+18,80, (screen_width-36)/5, 80);
            NSString *title = [_menuArray[i] objectForKey:@"title"];
            NSString *imageStr = [_menuArray[i] objectForKey:@"image"];
            JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
            btnView.tag = 10+i;
            [_backView1 addSubview:btnView];
            
            // 点击手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOneView:)];
            [btnView addGestureRecognizer:tap];
        }else if(i < 15){
            CGRect frame = CGRectMake((i-10)*(screen_width-36)/5+18, 0, (screen_width-36)/5, 80);
            NSString *title = [_menuArray[i] objectForKey:@"title"];
            NSString *imageStr = [_menuArray[i] objectForKey:@"image"];
            JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
            btnView.tag = 10+i;
            [_backView2 addSubview:btnView];
            
            // 点击手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOneView:)];
            [btnView addGestureRecognizer:tap];
        }else{
            CGRect frame = CGRectMake((i-15)*(screen_width-36)/5+18, 80, (screen_width-36)/5, 80);
            NSString *title = [_menuArray[i] objectForKey:@"title"];
            NSString *imageStr = [_menuArray[i] objectForKey:@"image"];
            JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
            btnView.tag = 10+i;
            [_backView2 addSubview:btnView];
            
            // 点击手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOneView:)];
            [btnView addGestureRecognizer:tap];
        }
    }
    
}

#pragma mark -手势点击事件

-(void)tapOneView:(UITapGestureRecognizer *)sender{
    
    
    if ([self.onTapBtnViewDelegate respondsToSelector:@selector(OnTapBtnView:)]) {
        
        [self.onTapBtnViewDelegate OnTapBtnView:sender];
    }
    
}



@end
