//
//  todetailsVC.m
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/21.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "todetailsVC.h"
#import "qtdetaCell.h"
#import "RqtDetailsCell.h"
#import "rqtDetModel.h"
#import "TextViewCell.h"
#import "todoController.h"
#import "NNNavigationController.h"
@interface todetailsVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *namesArray;
@property (nonatomic, strong) NSMutableArray *infosArray;
/**流程处理人数据源*/
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSString *opinionstr;
@end

@implementation todetailsVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    if ( [kFetchMyDefault(@"push")isEqualToString:@"push"]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"bolk"] forState:UIControlStateNormal];
        button.frame =CGRectMake(0, 0, 30, 30);
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -12, 0, 0)];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftButon= [[UIBarButtonItem alloc] initWithCustomView:button];
        UIBarButtonItem *fixedButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFixedSpace target:nil action:nil];

        fixedButton.width= -15;
        self.navigationItem.leftBarButtonItems= @[fixedButton,leftButon];
    }
}
-(void)back{
    NSLog(@"232131");
     kSaveMyDefault(@"push",@"");
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//
//    if ([controller isKindOfClass:[todoController class]]) {
//
//    todoController *todovc =(todoController *)controller;
//
//    [self.navigationController popToViewController:todovc animated:YES];
//
//    }

[self.navigationController popToRootViewControllerAnimated:YES];
    //    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
     self.title =@"待处理详情";
       self.view.backgroundColor=[UIColor whiteColor];
       _array=[NSMutableArray array];
       _infosArray=[NSMutableArray array];
       _namesArray=[NSMutableArray array];
       _dataSource=[NSMutableArray array];
//       [self RqtDetailsData];
}
#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, ScreenH-SK_TabbarSafeBottomMargin) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView=[self subFooterView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
         return 50;
    }else{
        return 150;
    }
}
#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return self.array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
         return [_array[section] count];
  
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
      qtdetaCell *cell =[qtdetaCell  qtdetaTableViewCellWithTableView:tableView];
        cell.titleLabel.text=_namesArray[indexPath.row];
        cell.rightLabel.text=_infosArray[indexPath.row];
         return cell;
    }else if (indexPath.section==1){
        RqtDetailsCell *cell =[ RqtDetailsCell rqtDetTableViewCellWithTableView:tableView];
        rqtDetModel *model = self.dataSource[indexPath.row];
        if (indexPath.row == 0) {
            [cell.onLine removeFromSuperview];
           }
        if (indexPath.row == self.dataSource.count-1) {
            [cell.downLine removeFromSuperview];
        }
          cell.model = model;
           return cell;
    }else{
        TextViewCell *cell =[TextViewCell      TextViewTableViewCellWithTableView:tableView];
                       __weak typeof(self) weakSelf = self;
                      [cell.textView didChangeText:^(PlaceholderTextView *textView) {
                             weakSelf.opinionstr=  textView.text;
                            
                      }];
        cell.titleLabel.text =@"处理意见";
        return cell;
    }
    
}
//使cell的下划线顶头
-(void)tableView:(UITableView* )tableView willDisplayCell:(UITableViewCell* )cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
[cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
    }
}
//底部
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if(section==2){
//       return 80 ;
//    }
      return 15;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
  
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, 15)];
      if (section==0||section==1) {
         headerView.backgroundColor=RGB(238, 238, 238);
  
    }
    return headerView;
}
-(UIView *)subFooterView{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, 80)];
           for (int i=0; i<2; i++) {
           UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
           button.frame=CGRectMake(i*(ScreenW/2)+(ScreenW/4)-50,20,100,40);
           button.tag=i;
               if (i==0) {
               [button setTitle:@"同意" forState:UIControlStateNormal];
               button.backgroundColor=RGB(234, 24, 24);
               }else{
               [button setTitle:@"拒绝" forState:UIControlStateNormal];
               button.backgroundColor=RGB(13, 163, 38);
               }
           [button addTarget:self action:@selector(buttonaudit:) forControlEvents:UIControlEventTouchUpInside];
                         [headerView addSubview:button];
           }
           return headerView;
}
- (void)RqtDetailsData{
    NSString *urlStr =[NSString stringWithFormat:@"%@xdtapp/api/v1/flowPath/getMyApplyMatterInfo",kAPI_URL];
    NSDictionary *dict =@{@"ticket": kFetchMyDefault(@"ticket"),@"matterId":_matterIdstr};
    [ZXDNetworking GET:urlStr parameters:dict success:^(id responseObject) {
        if ([responseObject[@"code"] intValue]==0) {
            for (NSString *str in responseObject[@"data"][@"infos"]) {
                 [ self.infosArray addObject:str];
            }
            for (NSString *namestr in responseObject[@"data"][@"names"]) {
                [ self.namesArray addObject:namestr];
            }
           [self.array addObject: self.namesArray];
        
            for (NSDictionary *dic in responseObject[@"data"][@"matters"]) {
                rqtDetModel *model = [rqtDetModel rqtDetWithDict:dic];
                [self.dataSource addObject:model];
            }
            if (self.dataSource.count==0) {
        self.tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@""
        titleStr:@"暂无数据"
        detailStr:@""];
            }
            [self.dataSource removeLastObject];
            [self.array addObject:self.dataSource];
            NSArray *arr= @[@"处理意见"];
            [self.array addObject:arr];
           [self.tableView reloadData];
          }
    } failure:^(NSError *error) {
        
    } view:self.view MBPro:YES];
}
-(void)buttonaudit:(UIButton*)sender{
     if (sender.tag==1&&!self.opinionstr.length){
        [ELNAlerTool showAlertMassgeWithController:self andMessage:@"请输入处理意见" andInterval:1.0];
    }else {
        NSString *urlStr =[NSString stringWithFormat:@"%@xdtapp/api/v1/approval/checkLeave",kAPI_URL];
        NSDictionary *dict =@{@"ticket":   kFetchMyDefault(@"ticket"),@"matterId":_matterIdstr,@"flag":[NSString stringWithFormat:@"%ld",(long)sender.tag],@"note":self.opinionstr};
           [ZXDNetworking POST:urlStr parameters:dict success:^(id responseObject) {
               if ([responseObject[@"code"] intValue]==0) {
                  
                 }
            } failure:^(NSError *error) {

         } view:self.view];
    }
  
}
@end
