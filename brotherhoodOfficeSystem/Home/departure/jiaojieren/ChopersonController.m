//
//  ChopersonController.m
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/15.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "ChopersonController.h"
#import "GroupModel.h"
#import "FriendModel.h"
#import "FriendTableViewCell.h"
#import "CustomHeadFooterView.h"

@interface ChopersonController ()<UITableViewDataSource,UITableViewDelegate,CustomHeadFooterViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *groups;

@end

@implementation ChopersonController

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,ScreenW,ScreenH-SK_TabbarSafeBottomMargin) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.sectionHeaderHeight = 44;
        _tableView.sectionFooterHeight= 1;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"选择交接人";
    self.groups=[NSArray array];
    [self updataetype];
    self.view.backgroundColor = [UIColor whiteColor];
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    GroupModel *group = self.groups[section];
    if (group.visible) {
        return group.users.count;
    }else{
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GroupModel *group = self.groups[indexPath.section];
    FriendModel *friend = group.users[indexPath.row];

    FriendTableViewCell *cell = [FriendTableViewCell friendTableViewCellWithTableView:tableView];
    cell.friendModel = friend;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 56;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    GroupModel *group = self.groups[section];
    CustomHeadFooterView *view = [CustomHeadFooterView headFooterViewWithTableview:tableView];
    view.delegate = self;
    view.group = group;
    view.tag = section;
    //return 返回之前headerFooterView的frame是0,所以需要在某个地方设置headerFooterView的frame
    return view;
    //return 返回之后，uitableview在用headerFooterView的时候就会设置headerFooterView的frame
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc]init];
}
//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GroupModel *group =self.groups[indexPath.section];
    FriendModel *friend =group.users[indexPath.row];
    if (self.num==0) {
        self.blcokFriendStr(friend);
    }else{
        self.blcokworkStr(friend);
    }
  
    
   [self.navigationController popViewControllerAnimated:YES];
}
-(void)groupHeaderViewDidClickTitleButton:(CustomHeadFooterView *)headerview{
    //全局刷新
//    [self.tv reloadData];
    //局部刷新
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:headerview.tag];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}
-(void)updataetype{
 
    NSString *urlStr =[NSString stringWithFormat:@"%@xdtapp/api/v1/quit/getToUsers",kAPI_URL];
    NSDictionary *dict =@{@"ticket":   kFetchMyDefault(@"ticket")};
    [ZXDNetworking GET:urlStr parameters:dict success:^(id responseObject) {
        if ([responseObject[@"code"] intValue]==0) {
          NSMutableArray *arrayModels = [NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"data"]) {
    GroupModel *group = [GroupModel mj_objectWithKeyValues:dic];
            [arrayModels addObject:group];
            }
           self.groups = [arrayModels copy];
           [self.view addSubview:self.tableView];
          }
    } failure:^(NSError *error) {
        
    } view:self.view MBPro:YES];
   
}
@end
