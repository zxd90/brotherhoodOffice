//
//  AttendController.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/8.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "AttendController.h"
#import "ClockView.h"
@interface AttendController ()<ClockonDelegate>

@end

@implementation AttendController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"考勤";
    self.view.backgroundColor =[UIColor whiteColor];
   ClockView *clockon = [[ClockView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, ScreenH-SK_TabbarSafeBottomMargin)];
          clockon.clockonDelegate = self;
       [self.view addSubview:clockon];
}
-(void)Clockontap{
    
}


@end
