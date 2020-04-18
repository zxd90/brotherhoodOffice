//
//  RqtDetailsController.m
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/18.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "RqtDetailsController.h"
#import "qtdetaCell.h"
#import "RqtDetailsCell.h"
#import "rqtDetModel.h"
#import "qtdetaModel.h"
@interface RqtDetailsController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;
/**流程处理人数据源*/
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation RqtDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"详情";
    self.view.backgroundColor=[UIColor whiteColor];
    _dataArray=@[@[@"姓名",@"部门",@"职位"],@[@"请假类型",@"开始时间",@"结束时间"],@[@"请假原因"]];
    [self RqtDetailsData];
}
#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, ScreenH-SK_ButtonHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==2) {
         return 150;
    }else{
        return 50;
    }
}
#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return [_dataArray[section]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        static NSString *CellIdentifier = @"qtdetaCell";
        
         qtdetaCell *cell = [[qtdetaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
             if (!cell) {
                 cell = [[qtdetaCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
             }
         cell.titleLabel.text=_dataArray[indexPath.section][indexPath.row];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
         return cell;
    }else{
        RqtDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RqtDetailsCell"];
          rqtDetModel *model = self.dataSource[indexPath.row];
          cell.selectionStyle = UITableViewCellSelectionStyleNone;
          
          if (indexPath.row == 0) {
              model.wuliuCellPosition = WuliuCellPositionTop;
          }else if (indexPath.row == self.dataSource.count - 1){
              model.wuliuCellPosition = WuliuCellPositionTail;
          }else {
              model.wuliuCellPosition = WuliuCellPositionMid;
          }
          
          cell.model = model;
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
#pragma mark - delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return [[UIView alloc] init];
//}
//
//底部
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15 ;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, 15)];
    if (section==1||section==0) {
       headerView.backgroundColor=RGB(238, 238, 238);
    }
    return headerView;
}
- (void)RqtDetailsData{
    NSString *urlStr =[NSString stringWithFormat:@"%@xdtapp/api/v1/flowPath/getMyApplyMatterInfo",kAPI_URL];
    NSDictionary *dict =@{@"ticket":   kFetchMyDefault(@"ticket"),@"matterId":_str};
    [ZXDNetworking GET:urlStr parameters:dict success:^(id responseObject) {
        if ([responseObject[@"code"] intValue]==0) {
          
            for (NSDictionary *dic in responseObject[@"data"][@"matters"]) {
//                qtdetaModel *model = [requstModel requstWithDict:dic];
//                [self.dataSource addObject:model];
            }
           [self.tableView reloadData];
          }
    } failure:^(NSError *error) {
        
    } view:self.view MBPro:YES];
}

@end
