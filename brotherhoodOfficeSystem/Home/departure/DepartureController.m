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
#import "TextViewCell.h"
@interface DepartureController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong)UIButton *button;
@end

@implementation DepartureController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"申请离职";
    self.tableView.hidden = NO;
    [self.view addSubview:self.button];
  _dataArray=@[@[@"姓名",@"部门",@"职位"],@[@"离职日期"],@[@"离职原因"],@[@"工作交接"]];
}
#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenW , ScreenH-SK_TabbarSafeBottomMargin-40) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (UIButton *)button{
    if (!_button) {
        _button= [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenH-SK_TabbarSafeBottomMargin-40,ScreenW, 40+SK_TabbarSafeBottomMargin)];
           [_button setBackgroundImage:[ZXDmethod ButtonColorLayer] forState:UIControlStateNormal];
            [_button setTitle:@"提交" forState:UIControlStateNormal];
            [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
                 
    }
    return _button;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==2||indexPath.section==3) {
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
//使cell的下划线顶头
-(void)tableView:(UITableView* )tableView willDisplayCell:(UITableViewCell* )cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
[cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
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
    if (section==1||section==0) {
       headerView.backgroundColor=RGB(238, 238, 238);
    }
    return headerView;
}

@end
