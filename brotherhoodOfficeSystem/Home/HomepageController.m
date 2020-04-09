//
//  HomepageController.m
//  brotherhoodMall
//
//  Created by 费腾 on 2020/3/18.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "HomepageController.h"
#import "HomeMenuCell.h"
#import "AttendController.h"
#import "AskLeaveController.h"
#import "InductionController.h"
#import "DepartureController.h"
#import "todoController.h"
@interface HomepageController ()<UITableViewDelegate,UITableViewDataSource,OnTapBtnViewDelegate>
@property(nonatomic,copy)NSMutableArray *menuArray;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation HomepageController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化数据
    [self initData];
    
    // 创建TableView
    [self setUpTableView];
    
}

#pragma mark -初始化数据

-(void)initData{

    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Property" ofType:@"plist"];
    _menuArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
}

#pragma mark -创建TableView

- (void)setUpTableView {
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.frame;
     gradientLayer.colors = @[(id)RGBA(55, 145, 240, 1).CGColor,(id)RGBA(47, 109, 224, 1).CGColor];  // 设置渐变颜色
     gradientLayer.locations = @[@0.0,@0.7];    // 颜色的起点位置，递增，并且数量跟颜色数量相等
     gradientLayer.startPoint = CGPointMake(0.3, 0);   //
     gradientLayer.endPoint = CGPointMake(0.5, 1);
     [view.layer addSublayer:gradientLayer];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView=view;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        
return  1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view=[[UIView alloc] init];
    view.backgroundColor =RGB(238, 238, 238);
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        static NSString *cellIndentifier = @"menucell";
        HomeMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[HomeMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier menuArray:_menuArray];
        }
     
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.onTapBtnViewDelegate = self;
        return cell;} else {
        
            static NSString *cellIndentifier = @"menucellA";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            
            if (cell == nil) {
                
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        
        }

}

#pragma mark -OnTapBtnViewDelegate

- (void)OnTapBtnView:(UITapGestureRecognizer *)sender {

      NSLog(@"tag:%ld",sender.view.tag);
    switch (sender.view.tag) {
               case 10:{
                   //考勤
                AttendController *AttendVC = [[AttendController alloc]init];
                [self.navigationController pushViewController:AttendVC animated:YES];
               }
                   break;
               case 11:{
                   //请假
                AskLeaveController *AskLeaveVC = [[AskLeaveController alloc]init];
                [self.navigationController pushViewController:AskLeaveVC animated:YES];
               }
                   break;
               case 12:{
                   //入职
               InductionController *InductionVC = [[InductionController alloc]init];
              [self.navigationController pushViewController:InductionVC animated:YES];
               }
                   break;
               case 13:{
                   //离职
                DepartureController *DepartureVC = [[DepartureController alloc]init];
                [self.navigationController pushViewController:DepartureVC animated:YES];
               }
                   break;
               case 14:
                   //待办事项
               {
               todoController *todoVC = [[todoController alloc]init];
               [self.navigationController pushViewController:todoVC animated:YES];
               }
                   break;
               default:
                   break;
               }

}



@end
