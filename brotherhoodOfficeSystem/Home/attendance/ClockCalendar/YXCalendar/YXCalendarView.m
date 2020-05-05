//
//  YXCalendarView.m
//  Calendar
//
//  Created by Vergil on 2017/7/6.
//  Copyright © 2017年 Vergil. All rights reserved.
//

#import "YXCalendarView.h"

static CGFloat const yearMonthH = 40;   //年月高度
static CGFloat const weeksH = 30;       //周高度
#define ViewW self.frame.size.width     //当前视图宽度
#define ViewH self.frame.size.height    //当前视图高度

@interface YXCalendarView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UILabel *yearMonthL;      //年月label
@property (nonatomic, strong) UIScrollView *scrollV;    //scrollview
@property (nonatomic, assign) CalendarType type;        //选择类型
@property (nonatomic, strong) NSDate *currentDate;      //当前月份
@property (nonatomic, strong) NSDate *selectDate;       //选中日期
@property (nonatomic, strong) NSDate *tmpCurrentDate;   //记录上下滑动日期

@property (nonatomic, strong) YXMonthView *leftView;    //左侧日历
@property (nonatomic, strong) YXMonthView *middleView;  //中间日历
@property (nonatomic, strong) YXMonthView *rightView;   //右侧日历

@end

@implementation YXCalendarView

- (instancetype)initWithFrame:(CGRect)frame Date:(NSDate *)date Type:(CalendarType)type {
    
    if (self = [super initWithFrame:frame]) {
        _type = type;
        _currentDate = date;
        _selectDate = date;
        if (type == CalendarType_Week) {
            _tmpCurrentDate = date;
            _currentDate = [[YXDateHelpObject manager] getLastdayOfTheWeek:date];
        }
        [self settingViews];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeHeaderHeightToLow) name:@"changeHeaderHeightToLow" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeHeaderHeightToHeigh) name:@"changeHeaderHeightToHeigh" object:nil];
    }
    return self;
}

- (void)dealloc
{
    [_scrollV removeObserver:self forKeyPath:@"contentOffset"];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//MARK: - setMethod

-(void)setType:(CalendarType)type {
    _type = type;
    
    _middleView.type = type;
    _leftView.type = type;
    _rightView.type = type;
    
    if (type == CalendarType_Week) {
        //周
        if (_refreshH) {
            if (ViewH == dayCellH + yearMonthH + weeksH) {
                return;
            }
            _refreshH(dayCellH + yearMonthH + weeksH);
            __weak typeof(_scrollV) weakScroll = _scrollV;
            [UIView animateWithDuration:0 animations:^{
                weakScroll.frame = CGRectMake(0, yearMonthH + weeksH, ViewW, dayCellH);
            }];
        }
    } else {
        //月
        if (_refreshH) {
            CGFloat viewH = [YXCalendarView getMonthTotalHeight:_currentDate type:CalendarType_Month];
            if (viewH == ViewH) {
                return;
            }
            _refreshH(viewH);
            __weak typeof(_scrollV) weakScroll = _scrollV;
            [UIView animateWithDuration:0.3 animations:^{
                weakScroll.frame = CGRectMake(0, yearMonthH + weeksH, ViewW, viewH - yearMonthH - weeksH);
            }];
        }
    }
}
/**
 *  说明此时正在往上滑
 */
- (void)changeHeaderHeightToLow{
    if (_type == CalendarType_Week) {
        return;
    }
    _tmpCurrentDate = _currentDate.copy;
    if (_selectDate && [[YXDateHelpObject manager] checkSameMonth:_selectDate AnotherMonth:_currentDate]) {
        _currentDate = [[YXDateHelpObject manager] getLastdayOfTheWeek:_selectDate];
        _middleView.currentDate = _currentDate;
        _leftView.currentDate = [[YXDateHelpObject manager]getEarlyOrLaterDate:_currentDate LeadTime:-7 Type:2];
        _rightView.currentDate = [[YXDateHelpObject manager]getEarlyOrLaterDate:_currentDate LeadTime:7 Type:2];
    } else {
        //默认第一周
        _currentDate = [[YXDateHelpObject manager] getLastdayOfTheWeek:[[YXDateHelpObject manager] GetFirstDayOfMonth:_currentDate]];
        _middleView.currentDate = _currentDate;
        _leftView.currentDate = [[YXDateHelpObject manager]getEarlyOrLaterDate:_currentDate LeadTime:-7 Type:2];
        _rightView.currentDate = [[YXDateHelpObject manager]getEarlyOrLaterDate:_currentDate LeadTime:7 Type:2];
        
    }
    self.type = CalendarType_Week;
    [self setType:_type];
}
/**
 *  说明此时正在往下滑
 */
- (void)changeHeaderHeightToHeigh{
    if (_type == CalendarType_Month) {
        return;
    }
    //选中最后一行再上滑需要这个判断
    if (![[YXDateHelpObject manager] checkSameMonth:_tmpCurrentDate AnotherMonth:_currentDate]) {
        _currentDate = _tmpCurrentDate.copy;
    }
    _type = CalendarType_Month;
    [self setType:_type];
    [self setData];
    [self scrollToCenter];
}
//MARK: - otherMethod
+ (CGFloat)getMonthTotalHeight:(NSDate *)date type:(CalendarType)type {
    if (type == CalendarType_Week) {
        return yearMonthH + weeksH + dayCellH;
    } else {
        NSInteger rows = [[YXDateHelpObject manager] getRows:date];
        return yearMonthH + weeksH + rows * dayCellH;
    }
}
- (void)settingViews {
    [self settingHeadLabel];
    [self settingScrollView];
    [self addObserver];
}

- (void)settingHeadLabel {
    
    _yearMonthL = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW/2-60, 0, 120, yearMonthH)];
    _yearMonthL.text = [[YXDateHelpObject manager] getStrFromDateFormat:@"yyyy年MM月" Date:_currentDate];
    _yearMonthL.textAlignment = NSTextAlignmentCenter;
    _yearMonthL.font = [UIFont systemFontOfSize:15];
    [self addSubview:_yearMonthL];
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
 leftButton.frame=CGRectMake(_yearMonthL.left-yearMonthH,0,yearMonthH,yearMonthH);
        [leftButton setImage:[UIImage imageNamed:@"bolk"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftMonth) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftButton];
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
       rightButton.frame=CGRectMake(_yearMonthL.right,0,yearMonthH, yearMonthH);
     [rightButton setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
       [rightButton addTarget:self action:@selector(rightMonth) forControlEvents:UIControlEventTouchUpInside];
       [self addSubview:rightButton];
    NSArray *weekdays = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    CGFloat weekdayW = ViewW/7;
    for (int i = 0; i < 7; i++) {
        UILabel *weekL = [[UILabel alloc] initWithFrame:CGRectMake(i*weekdayW, yearMonthH, weekdayW, weeksH)];
        weekL.textAlignment = NSTextAlignmentCenter;
        weekL.font = [UIFont systemFontOfSize:15];
        weekL.textColor=RGB(13, 163, 38);
        weekL.text = weekdays[i];
        [self addSubview:weekL];
    }
    
}

- (void)settingScrollView {
    
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, yearMonthH + weeksH, ViewW, ViewH - yearMonthH - weeksH)];
    _scrollV.contentSize = CGSizeMake(ViewW * 3, 0);
    _scrollV.pagingEnabled = YES;
    _scrollV.showsHorizontalScrollIndicator = NO;
    _scrollV.showsVerticalScrollIndicator = NO;
    _scrollV.delegate = self;
    [self addSubview:_scrollV];
    
    __weak typeof(self) weakSelf = self;
    CGFloat height = 6 * dayCellH;
    _leftView = [[YXMonthView alloc] initWithFrame:CGRectMake(0, 0, ViewW, height) Date:
                 _type == CalendarType_Month ? [[YXDateHelpObject manager] getPreviousMonth:_currentDate] :[[YXDateHelpObject manager]getEarlyOrLaterDate:_currentDate LeadTime:-7 Type:2]];
    _leftView.type = _type;
    _leftView.selectDate = _selectDate;
    
    _middleView = [[YXMonthView alloc] initWithFrame:CGRectMake(ViewW, 0, ViewW, height) Date:_currentDate];
    _middleView.type = _type;
    _middleView.selectDate = _selectDate;
    _middleView.sendSelectDate = ^(NSDate *selDate) {
        weakSelf.selectDate = selDate;
        if (weakSelf.sendSelectDate) {
            weakSelf.sendSelectDate(selDate);
        }
        [weakSelf setData];
    };
    
    _rightView = [[YXMonthView alloc] initWithFrame:CGRectMake(ViewW * 2, 0, ViewW, height) Date:
                  _type == CalendarType_Month ? [[YXDateHelpObject manager] getNextMonth:_currentDate] : [[YXDateHelpObject manager]getEarlyOrLaterDate:_currentDate LeadTime:7 Type:2]];
    _rightView.type = _type;
    _rightView.selectDate = _selectDate;
    
    [_scrollV addSubview:_leftView];
    [_scrollV addSubview:_middleView];
    [_scrollV addSubview:_rightView];
    
    [self scrollToCenter];
}

- (void)setData {
    
    if (_type == CalendarType_Month) {
        _middleView.currentDate = _currentDate;
        _middleView.selectDate = _selectDate;
        _leftView.currentDate = [[YXDateHelpObject manager] getPreviousMonth:_currentDate];
        _leftView.selectDate = _selectDate;
        _rightView.currentDate = [[YXDateHelpObject manager] getNextMonth:_currentDate];
        _rightView.selectDate = _selectDate;
    } else {
        _middleView.currentDate = _currentDate;
        _middleView.selectDate = _selectDate;
        _leftView.currentDate = [[YXDateHelpObject manager] getEarlyOrLaterDate:_currentDate LeadTime:-7 Type:2];
        _leftView.selectDate = _selectDate;
        _rightView.currentDate = [[YXDateHelpObject manager] getEarlyOrLaterDate:_currentDate LeadTime:7 Type:2];
        _rightView.selectDate = _selectDate;
    }
    
    self.type = _type;
    
}

//MARK: - kvo
- (void)addObserver {
    [_scrollV addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self monitorScroll];
    }
    
}
//上个月
-(void)leftMonth{
    [self slideTheDateToLastmonth];
}
//下个月
-(void)rightMonth{
    [self slideTheDateToNextmonth];
}
//左右滑动
- (void)monitorScroll {
  if (_scrollV.contentOffset.x > 2*ViewW -1) {
      [self slideTheDateToNextmonth];
    } else if (_scrollV.contentOffset.x < 1) {
        [self slideTheDateToLastmonth];
    }
}
//右滑,上个月
-(void)slideTheDateToLastmonth{
    if (_type == CalendarType_Month) {
              //右滑,上个月
              _middleView.currentDate = [[YXDateHelpObject manager] getPreviousMonth:_currentDate];
              _middleView.selectDate = _selectDate;
              _rightView.currentDate = _currentDate;
              _rightView.selectDate = _selectDate;
              _currentDate = [[YXDateHelpObject manager] getPreviousMonth:_currentDate];
              _leftView.currentDate = [[YXDateHelpObject manager] getPreviousMonth:_currentDate];
              _leftView.selectDate = _selectDate;
              _yearMonthL.text = [[YXDateHelpObject manager] getStrFromDateFormat:@"yyyy年MM月" Date:_currentDate];
          } else {
              //上周
              _middleView.currentDate = [[YXDateHelpObject manager] getEarlyOrLaterDate:_currentDate LeadTime:-7 Type:2];
              _middleView.selectDate = _selectDate;
              _rightView.currentDate = _currentDate;
              _rightView.selectDate = _selectDate;
              _currentDate = [[YXDateHelpObject manager] getEarlyOrLaterDate:_currentDate LeadTime:-7 Type:2];
              _tmpCurrentDate = _currentDate.copy;
              _leftView.currentDate = [[YXDateHelpObject manager] getEarlyOrLaterDate:_currentDate LeadTime:-7 Type:2];
              _leftView.selectDate = _selectDate;
              _yearMonthL.text = [[YXDateHelpObject manager] getStrFromDateFormat:@"yyyy年MM月" Date:_currentDate];
          }
          
          [self scrollToCenter];
          self.type = _type;
}
//向左滑动,下个月
-(void)slideTheDateToNextmonth{
      
          if (_type == CalendarType_Month) {
              //左滑,下个月
              _middleView.currentDate = [[YXDateHelpObject manager] getNextMonth:_currentDate];
              _middleView.selectDate = _selectDate;
              _leftView.currentDate = _currentDate;
              _leftView.selectDate = _selectDate;
              _currentDate = [[YXDateHelpObject manager] getNextMonth:_currentDate];
              _rightView.currentDate = [[YXDateHelpObject manager] getNextMonth:_currentDate];
              _rightView.selectDate = _selectDate;
              _yearMonthL.text = [[YXDateHelpObject manager] getStrFromDateFormat:@"yyyy年MM月" Date:_currentDate];
          } else {
              //下周
              _middleView.currentDate = [[YXDateHelpObject manager] getEarlyOrLaterDate:_currentDate LeadTime:7 Type:2];
              _middleView.selectDate = _selectDate;
              _leftView.currentDate = _currentDate;
              _leftView.selectDate = _selectDate;
              _currentDate = [[YXDateHelpObject manager] getEarlyOrLaterDate:_currentDate LeadTime:7 Type:2];
              _tmpCurrentDate = _currentDate.copy;
              _rightView.currentDate = [[YXDateHelpObject manager] getEarlyOrLaterDate:_currentDate LeadTime:7 Type:2];
              _rightView.selectDate = _selectDate;
              _yearMonthL.text = [[YXDateHelpObject manager] getStrFromDateFormat:@"yyyy年MM月" Date:_currentDate];
          }
          
          [self scrollToCenter];
          self.type = _type;
}

//MARK: - scrollViewMethod
- (void)scrollToCenter {
    _scrollV.contentOffset = CGPointMake(ViewW, 0);
    
    //可以在这边进行网络请求获取事件日期数组等,记得取消上个未完成的网络请求
    //取消当前界面的数据请求[self.task cancel];
    //@property(nonatomic,strong)NSURLSessionDataTask*task;
   
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        NSString *dateStr = [NSString stringWithFormat:@"%@-%d",[[YXDateHelpObject manager] getStrFromDateFormat:@"MM" Date:_currentDate],1 + arc4random()%28];
        [array addObject:dateStr];
    }
    
    _middleView.eventArray = array;
}

@end
