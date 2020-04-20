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
@property (nonatomic, strong) NSMutableArray *namesArray;
@property (nonatomic, strong) NSMutableArray *infosArray;
/**流程处理人数据源*/
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation RqtDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"详情";
    self.view.backgroundColor=[UIColor whiteColor];
    _array=[NSMutableArray array];
    _infosArray=[NSMutableArray array];
    _namesArray=[NSMutableArray array];
    _dataSource=[NSMutableArray array];
    [self RqtDetailsData];
}
#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, ScreenH-SK_TabbarSafeBottomMargin) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==1) {
         return 150;
    }else{
        return 50;
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
    }else{
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
            [self.array addObject:self.dataSource];
           [self.tableView reloadData];
          }
    } failure:^(NSError *error) {
        
    } view:self.view MBPro:YES];
}

@end
