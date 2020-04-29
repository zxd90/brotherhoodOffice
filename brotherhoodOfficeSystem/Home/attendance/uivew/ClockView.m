//
//  ClockView.m
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/28.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "ClockView.h"
#import "ClockTableViewCell.h"
#import "clockModel.h"
@interface ClockView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;
@end
@implementation ClockView
-(instancetype)initWithFrame:(CGRect)frame{

    if(self = [super initWithFrame:frame]){
         
              self.tableView.hidden = NO;
    }
    return  self;
}
#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, ScreenH-SK_TabbarSafeBottomMargin) style:UITableViewStylePlain];
         
        //        _tableView.rowHeight = UITableViewAutomaticDimension;        //_tableView.estimatedRowHeight = 180;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //去除多余的cell线
        [ZXDNetworking setExtraCellLineHidden:_tableView];
        [self addSubview:_tableView];
    }
    return _tableView;
}
- (NSArray *)dataArray {
    if (!_dataArray) {
       _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
return 200;
     
}
#pragma mark - UITableViewDataSource, UITableViewDelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        ClockTableViewCell *cell =[ClockTableViewCell ClockTableViewCellWithTableView:tableView];
        cell.separatorInset = UIEdgeInsetsMake(0,ScreenW, 0, 0);
        clockModel *model= _dataArray[indexPath.row];
        cell.cloModel=model;
        if (indexPath.row == 0) {
            [cell.onLine removeFromSuperview];
            cell.timelabel.text=[NSString stringWithFormat:@"上班时间%@",model.time];
            }else{
            [cell.downLine removeFromSuperview];
            cell.timelabel.text=[NSString stringWithFormat:@"下班时间%@",model.time];
           }
    return cell;
}

//点击打卡
- (void)tapIcon:(UITapGestureRecognizer *)tap{

    if ([self.clockonDelegate respondsToSelector:@selector(Clockontap)]) {
        [self.clockonDelegate Clockontap];
    }
}
-(void)addClockonarray:(NSArray*)arr{
    
    _dataArray= arr;
    [self.tableView reloadData];
}

@end
