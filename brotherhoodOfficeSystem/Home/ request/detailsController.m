//
//  detailsController.m
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/21.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "detailsController.h"
#import "qtdetaCell.h"
@interface detailsController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *namesArray;
@property (nonatomic, strong) NSMutableArray *infosArray;
/**流程处理人数据源*/
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation detailsController

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
  
      qtdetaCell *cell =[qtdetaCell  qtdetaTableViewCellWithTableView:tableView];
        cell.titleLabel.text=_namesArray[indexPath.row];
        cell.rightLabel.text=_infosArray[indexPath.row];
         return cell;
    
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
    return 15 ;
}
//-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, 15)];
//    if (section==0) {
//       headerView.backgroundColor=RGB(238, 238, 238);
//    }
//    return headerView;
//}
-(UIView *)subHeaderView{
  
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenW,(ScreenW-80)/2.8+80)];
       UIView * View = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, 15)];
         View.backgroundColor=RGB(238, 238, 238);
        [headerView addSubview:View];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15,View.bottom+10 ,200 ,20)];
        label.text=@"身份证正反面照片";
        label.font=[UIFont systemFontOfSize:16.0];
        [headerView addSubview:label];
    NSLog(@"%@",self.dataSource[0]);
    for (int i=0; i<2; i++) {
        UIImageView *iamge=[[UIImageView alloc]initWithFrame:CGRectMake(i*(ScreenW/2)+20, label.bottom+10,(ScreenW/2-40),(ScreenW-80)/2.8)];
        [iamge sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.dataSource[i]]] placeholderImage:[UIImage imageNamed:@"renxiang0"]];
            [headerView addSubview:iamge];
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
        
            for (NSString *images in responseObject[@"data"][@"imgs"]) {
                [self.dataSource addObject:images];
            }
          
          self.tableView.tableFooterView=[self subHeaderView];
           [self.tableView reloadData];
          }
    } failure:^(NSError *error) {
        
    } view:self.view MBPro:YES];
}

@end
