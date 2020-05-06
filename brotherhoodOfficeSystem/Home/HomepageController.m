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
#import "HaveController.h"
#import "todoController.h"
#import "requestController.h"
#import "Homeheader.h"
@interface HomepageController ()<UITableViewDelegate,UITableViewDataSource,OnTapBtnViewDelegate>
@property(nonatomic,copy)NSMutableArray *menuArray;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong) Homeheader *headerView;
@property(nonatomic,strong) NSMutableArray *arry;
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
    [self GetTheroundbanner];

    
}

#pragma mark -初始化数据

-(void)initData{
   
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Property" ofType:@"plist"];
    _menuArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
}


#pragma mark -创建TableView
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,ScreenW,ScreenH-SK_TabbarSafeBottomMargin) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:self.tableView];
    }
    return _tableView;
}

- (void)setUpTableViewarr:(NSArray*)arr {
    _headerView=[[Homeheader alloc]initWithFrame:CGRectMake(0, 0, ScreenW, (ScreenH - SK_TabbarHeight) / 327 * 80+30)arr:arr];
    self.tableView.tableHeaderView=_headerView;
}
#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        
return  1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 175;
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
               HaveController *todoVC = [[HaveController alloc]init];
               [self.navigationController pushViewController:todoVC animated:YES];
               }
                   break;
              case 15:
                    //待办事项
               {
                          todoController *todoVC = [[todoController alloc]init];
                          [self.navigationController pushViewController:todoVC animated:YES];
                               
                }
                    break;
               case 16:
                    //待办事项
                {
                requestController *todoVC = [[requestController alloc]init];
                [self.navigationController pushViewController:todoVC animated:YES];
                                             
                }
                break;
               default:
                   break;
               }

}
-(void)GetTheroundbanner{
        NSString *urlStr =[NSString stringWithFormat:@"%@xdtapp/api/v1/banner",kAPI_URL];
        //NSDictionary *dict =@{@"ticket":kFetchMyDefault(@"ticket")};
        [ZXDNetworking GET:urlStr parameters:nil success:^(id responseObject) {
            NSMutableArray *arr=[NSMutableArray array];
            if ([responseObject[@"code"] intValue]==0) {
 
                for (NSDictionary *dict in responseObject[@"data"]) {
                    [arr addObject:dict[@"imgPath"]];
                    }
                // 创建TableView
                [self setUpTableViewarr:arr];
              
                [self.tableView reloadData];
                    }
        } failure:^(NSError *error) {
            
        } view:self.view MBPro:YES];
       
}
@end
