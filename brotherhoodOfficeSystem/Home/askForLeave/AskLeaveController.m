//
//  AskLeaveController.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/8.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "AskLeaveController.h"
#import "AskTableViewCell.h"
#import "SelecTableViewCell.h"
#import "TextViewCell.h"
@interface AskLeaveController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong)UIButton *button;
@end

@implementation AskLeaveController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"请假";
    self.tableView.hidden = NO;
    _dataArray=@[@[@"姓名",@"部门",@"职位"],@[@"请假类型",@"开始时间",@"结束时间"],@[@"请假原因"]];
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

- (UIButton *)button{
    if (!_button) {
        
    }
    return _button;
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
     if (section==0) {
        return [_dataArray[section]count];
       }else if(section==1) {
        return [_dataArray[section]count];
       }else{
        return [_dataArray[section]count];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        static NSString *CellIdentifier = @"AskTableViewCell";
        
         AskTableViewCell *cell = [[AskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
             if (!cell) {
                 cell = [[AskTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
             }
  cell.titleLabel.text=_dataArray[indexPath.section][indexPath.row];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
         return cell;
    }else  if(indexPath.section==1){
            static NSString *CellIdentifier = @"AskTableViewCell";
              SelecTableViewCell *cell = [[SelecTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                if (!cell) {
                cell=[[SelecTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
       cell.titleLabel.text=_dataArray[indexPath.section][indexPath.row];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
          return cell;
    }else{
        static NSString *CellIdentifier = @"TextViewCell";
                     TextViewCell *cell = [[TextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TextViewCell"];
                       if (!cell) {
                cell=[[TextViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                       }
             cell.titleLabel.text=_dataArray[indexPath.section][indexPath.row];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                 return cell;
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


@end
