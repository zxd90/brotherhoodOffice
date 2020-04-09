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
@interface AskLeaveController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation AskLeaveController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"请假";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenW , ScreenH) style:UITableViewStyleGrouped];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
         return 3;
    }else{
        return 3;
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        static NSString *CellIdentifier = @"AskTableViewCell";
           AskTableViewCell *cell = [[AskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AskTableViewCell"];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
             if (cell == nil) {
             cell=[[AskTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

             }
         return cell;
    }else{
            static NSString *CellIdentifier = @"AskTableViewCell";
              SelecTableViewCell *cell = [[SelecTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AskTableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (cell == nil) {
                cell=[[SelecTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    return [[UIView alloc] init];
//}

@end
