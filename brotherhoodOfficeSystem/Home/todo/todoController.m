//
//  todoController.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/8.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "todoController.h"
#import "haveCell.h"
#import "HaveModel.h"
#import "todetailsVC.h"
@interface todoController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *arrayModels;
@property (nonatomic,assign)NSUInteger page;
@property (nonatomic,assign)BOOL isFirstLoadData;
@property (nonatomic,assign)BOOL isRefreshFooter;
@end

@implementation todoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
     self.title =@"待办事项";
     self.arrayModels = [NSMutableArray array];
        self.page = 1;
        self.isFirstLoadData = NO;
        self.isRefreshFooter = NO;
        [self requstData];
       
    }
    #pragma mark - lazy
- (UITableView *)tableView {
        if (!_tableView) {
            _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, ScreenH-SK_TabbarSafeBottomMargin) style:UITableViewStylePlain];
            
            _tableView.backgroundColor = [UIColor whiteColor];
            _tableView.dataSource = self;
            _tableView.delegate = self;
               //添加下拉刷新
            _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                    self.page = 1;
                    self.isRefreshFooter = NO;
                    [self requstData];
                }];
        
                //上拉加载
                _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                    self.page++;
                    self.isRefreshFooter = YES;
                    [self requstData];
                }];
            //去除多余的cell线
            [ZXDNetworking setExtraCellLineHidden:_tableView];
            [self.view addSubview:_tableView];
        }
        return _tableView;
    }

    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
       
            return 76;
    }
#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
       return 1;
    }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       
        return _arrayModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        haveCell *cell =[haveCell  haveTableViewCellWithTableView:tableView];
        HaveModel *model= _arrayModels[indexPath.row];
        cell.haveModel=model;
               
               
        return cell;
}
    //使cell的下划线顶头
-(void)tableView:(UITableView* )tableView willDisplayCell:(UITableViewCell* )cell forRowAtIndexPath:(NSIndexPath *)indexPath
    {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
    [cell setSeparatorInset:UIEdgeInsetsZero];
        }
    }

#pragma mark - delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        HaveModel *model= _arrayModels[indexPath.row];
    todetailsVC *todeVC=[[todetailsVC alloc]init];
    todeVC.matterIdstr =model.matterId;
    [self.navigationController  pushViewController:todeVC animated:YES];
}
- (void)requstData{
        NSString *urlStr =[NSString stringWithFormat:@"%@xdtapp/api/v1/flowPath/getUntreatedMatter",kAPI_URL];
        NSDictionary *dict =@{@"ticket":   kFetchMyDefault(@"ticket"),@"pageNum":[NSString stringWithFormat:@"%lu",(unsigned long)self.page],@"pageSize":@"10"};
        [ZXDNetworking GET:urlStr parameters:dict success:^(id responseObject) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            if (self.isRefreshFooter==NO) {
                     [self.arrayModels removeAllObjects];
                 }
            if ([responseObject[@"code"] intValue]==0) {
                for (NSDictionary *dic in responseObject[@"data"] [@"records"]) {
                      HaveModel *model = [HaveModel haveWithDict:dic];
                    [self.arrayModels addObject:model];
                }
                NSLog(@"%@",self.arrayModels);
               [self.tableView reloadData];
              }
        } failure:^(NSError *error) {
            
        } view:self.view MBPro:YES];
    }
@end
