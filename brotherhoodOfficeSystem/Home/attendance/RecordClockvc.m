//
//  RecordClockvc.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/5/5.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "RecordClockvc.h"
#import "YXCalendarView.h"
#import "clockModel.h"
#import "RecordClockCell.h"
@interface RecordClockvc ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) YXCalendarView *calendar;

@property (nonatomic, strong) UITableView *tableView;
//获取投资日历的高度
@property (nonatomic, assign) CGFloat calendarHeight;
//数据
@property (nonatomic, strong) NSString *data;
//每次用户拖动tableView的时候，只能发送一次让tableView的header收起和展开的通知
@property (nonatomic, assign) BOOL isAllowPostNoti;
//
@property (nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation RecordClockvc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"考勤记录";
    self.view.backgroundColor = [UIColor whiteColor];
    //加载投资日历
    [self.view addSubview:self.calendar];
    //加载每日日历内容
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, SK_NavHeight+self.calendarHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-SK_NavHeight-self.calendarHeight);
    [self serviceDataByData:[[YXDateHelpObject manager] getStrFromDateFormat:@"yyyy-MM-dd" Date:[NSDate dateWithTimeInterval:-24*60*60 sinceDate:[NSDate date]]]];
    self.isAllowPostNoti = YES;
}

/**
 *tableView的懒加载
 */
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.estimatedRowHeight = 100;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.userInteractionEnabled = YES;
        
    }
    return _tableView;
}
/**
 *  日历的懒加载
 */
- (YXCalendarView *)calendar{
   //选中当前日期的前一天 [NSDate dateWithTimeInterval:-24*60*60 sinceDate:[NSDate date]]
    if(!_calendar){
        _calendar = [[YXCalendarView alloc] initWithFrame:CGRectMake(0, SK_NavHeight, ScreenW, [YXCalendarView getMonthTotalHeight:[NSDate date] type:CalendarType_Month]) Date:[NSDate dateWithTimeInterval:-24*60*60 sinceDate:[NSDate date]] Type:CalendarType_Month];
        self.calendarHeight = [YXCalendarView getMonthTotalHeight:[NSDate date] type:CalendarType_Month];
        __weak typeof (self) WeakSelf = self;
        //改变日历头部和tableView 的cell位置
        [self changeLocation];
        //点击日历某一个日期  进行数据刷新
        _calendar.sendSelectDate = ^(NSDate *selDate) {
            [WeakSelf serviceDataByData:[[YXDateHelpObject manager] getStrFromDateFormat:@"yyyy-MM-dd" Date:selDate]];
        };
    }
    return _calendar;
}
//请求数据
- (void)serviceDataByData:(NSString *)data{
    if ([self compareWithDate:data]==-1||[self compareWithDate:data]==0) {
        PWAlertView *alertView = [[PWAlertView alloc]initWithTitle:@"提示" message:@"只能查询当前日期之前的考勤" sureBtn:@"好的" cancleBtn:nil];
              alertView.resultIndex = ^(NSInteger index){
              };
        [alertView showMKPAlertView];
    }else{
    NSString *urlStr =[NSString stringWithFormat:@"%@xdtapp/api/v1/clock/getMyClockInfoByDate",kAPI_URL];
    NSDictionary *dict =@{@"ticket":kFetchMyDefault(@"ticket"),@"date":data};
           [ZXDNetworking GET:urlStr parameters:dict success:^(id responseObject) {
            
        self.dataArray=[NSMutableArray array];
           if ([responseObject[@"code"] intValue]==0) {
               for (NSDictionary *dict in responseObject[@"data"]) {
                 clockModel *clmodel=[clockModel clockDetWithDict:dict];
                   [self.dataArray addObject:clmodel];
               }
                   // 创建TableView
                [self.tableView reloadData];
               }
           } failure:^(NSError *error) {
               
           } view:self.view MBPro:YES];
    }

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        return _dataArray.count;
}
/**
 *  改变日历头部和tableView 的cell位置
 */
- (void)changeLocation{
    __weak typeof(_calendar) weakCalendar = _calendar;
    __weak typeof (self) WeakSelf = self;
    _calendar.refreshH = ^(CGFloat viewH) {
        WeakSelf.calendarHeight = viewH;
        [UIView animateWithDuration:0.3 animations:^{
            weakCalendar.frame = CGRectMake(0, SK_NavHeight, [UIScreen mainScreen].bounds.size.width, viewH);
            WeakSelf.tableView.frame = CGRectMake(0, SK_NavHeight+viewH, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-SK_NavHeight-viewH);
        }];
    };
}
/**
 *  通过监听tableViewcell的偏移量 从而判断tableView的头部应该收缩或者伸展
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y > 0) {
        NSNotification *notifi = [[NSNotification alloc] initWithName:@"changeHeaderHeightToLow" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notifi];
    }else if(scrollView.contentOffset.y < 0){
        NSNotification *notifi = [[NSNotification alloc] initWithName:@"changeHeaderHeightToHeigh" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notifi];
    }
}

#pragma mark - cellForRowAtIndexPath
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     RecordClockCell *cell =[RecordClockCell RecordClockTableViewCellWithTableView:tableView];
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
//判断时间大小
- (NSInteger)compareWithDate:(NSString*)bDate{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString*aDate=[formatter stringFromDate:[NSDate date]];
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd"];
      NSDate*dta = [[NSDate alloc]init];
        NSDate*dtb = [[NSDate alloc]init];
        dta = [dateformater dateFromString:aDate];
        dtb = [dateformater dateFromString:bDate];
        NSComparisonResult result = [dta compare:dtb];
        if (result == NSOrderedDescending) {
          //指定时间 已过期
               return 1;
           }else if(result ==NSOrderedAscending){
               //指定时间 没过期
               return -1;
           }else{
               //刚好时间一样.
               return 0;
           }
      }
@end
