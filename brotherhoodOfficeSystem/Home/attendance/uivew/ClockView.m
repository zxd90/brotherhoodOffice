//
//  ClockView.m
//  brotherhoodOfficeSystem
//
//  Created by XDT on 2020/4/28.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "ClockView.h"
#import "ClockTableViewCell.h"
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
        _tableView.dataSource = self;
        _tableView.delegate = self;
         [self addSubview:_tableView];
    }
    return _tableView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
return 50;
     
}
#pragma mark - UITableViewDataSource, UITableViewDelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        ClockTableViewCell *cell =[ClockTableViewCell ClockTableViewCellWithTableView:tableView];
             
    return cell;
}

//点击打卡
- (void)tapIcon:(UITapGestureRecognizer *)tap{

    if ([self.clockonDelegate respondsToSelector:@selector(Clockontap)]) {
        [self.clockonDelegate Clockontap];
    }
}
//底部
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
      
    return 15 ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
         return 15 ;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
       UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, 15)];
       headerView.backgroundColor=RGB(238, 238, 238);
    return headerView;
    }
    return [[UIView alloc]init];
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, 15)];
    if (section!=4) {
       headerView.backgroundColor=RGB(238, 238, 238);
    }
    return headerView;
}



@end
