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
#import "UIButton+HQCustomIcon.h"
@interface ClockView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong) NSString *addresStr;
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
        cell.address.text=_addresStr;
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
-(void)addClockonarray:(NSArray*)arr addrestr:(NSString*)addrestr{
    _addresStr=addrestr;
    _dataArray= arr;
    _tableView.tableHeaderView=[self headerView];
    [self.tableView reloadData];
}
/**
 点击日期事件
 */
-(void)buttonClick{
    if ([self.clockonDelegate respondsToSelector:@selector(AccessDateAttendancetap)]) {
        [self.clockonDelegate AccessDateAttendancetap];
       }
}
-(UIView*)headerView{
    UIView *headerview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW,76)];
     UIImageView  *headerImageView= [[UIImageView alloc]initWithFrame:CGRectMake(18, 13, 50, 50)];
       headerImageView.layer.cornerRadius = 20;
       headerImageView.layer.masksToBounds = YES;
     [headerImageView sd_setImageWithURL:[NSURL URLWithString:kFetchMyDefault(@"headImg")] placeholderImage:[UIImage imageNamed:@"touxiang"]];
       //右侧扩展说明内容
       [headerview addSubview: headerImageView];
       UILabel   *labelName = [[UILabel alloc]initWithFrame:CGRectMake(headerImageView.right+8,16,150, 20)];
       labelName.font = [UIFont systemFontOfSize:16];
       labelName.text = kFetchMyDefault(@"userName");
       [headerview addSubview: labelName]; //姓名文字
       UILabel *labelroleName = [[UILabel alloc]initWithFrame:CGRectMake(headerImageView.right+8,labelName.bottom+8,150, 20)];
        labelroleName.font = [UIFont systemFontOfSize:14];
        labelroleName.text=[NSString stringWithFormat:@"考勤分组:%@",kFetchMyDefault(@"depName")];
       [headerview addSubview:labelroleName];
       UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
         button.frame = CGRectMake(ScreenW-150,16,140,30);
         [button setImage:[UIImage imageNamed:@"xia"] forState:UIControlStateNormal];
         [button setTitle:[YearsTime getyyyymmdd] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
         [button setTitleColor:RGB(13, 163, 38)  forState:UIControlStateNormal];
         [button setIconInRightWithSpacing:5];
         [headerview addSubview:button];
        
    return headerview;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==0) {
         UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, 1)];
          headerView.backgroundColor=RGB(238, 238, 238);
        return headerView;
    }
    return [[UIView alloc] init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return 0;
}
@end
