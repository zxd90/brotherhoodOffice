//
//  DepartureController.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/8.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "DepartureController.h"
#import "AskTableViewCell.h"
#import "SelecTableViewCell.h"
@interface DepartureController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;
@end

@implementation DepartureController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"申请离职";
    self.tableView.hidden = NO; _dataArray=@[@[@"姓名",@"部门",@"职位"],@[@"离职日期"]];
}
#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenW , ScreenH) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
         return [_dataArray[section]count];
    }else{
        return [_dataArray[section]count];
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
       static NSString *cellID = @"testCell";
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
         if (!cell) {
             cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
         }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:16.0];
       cell.detailTextLabel.text = @"这是谁";
       cell.detailTextLabel.font = [UIFont systemFontOfSize:16.0];
       cell.detailTextLabel.textColor=[UIColor blackColor];
    return cell;
    }else{
            static NSString *CellIdentifier = @"AskTableViewCell";
              SelecTableViewCell *cell = [[SelecTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AskTableViewCell"];
           
                if (cell == nil) {
                cell=[[SelecTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
         cell.titleLabel.text=self.dataArray[indexPath.section][indexPath.row];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
          return cell;
        }
    

  
}

#pragma mark - delegate
//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return [[UIView alloc] init];
//}

//底部
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15 ;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, 15)];
    headerView.backgroundColor=RGB(238, 238, 238);
    return headerView;
}



@end
