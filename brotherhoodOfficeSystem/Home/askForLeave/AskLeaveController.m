//
//  AskLeaveController.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/8.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "AskLeaveController.h"
#import "LeaveTypemodle.h"
#import "TextViewCell.h"
@interface AskLeaveController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong)UIButton *button;

/** 请假类型 */
@property (nonatomic, strong) BRTextField *typeTF;
/** 开始日期 */
@property (nonatomic, strong) BRTextField *startDateTF;
/** 结束日期 */
@property (nonatomic, strong) BRTextField *endDateTF;
/** 开始时间*/
@property (nonatomic, strong) BRTextField *starTimeTF;
/**结束时间*/
@property (nonatomic, strong) BRTextField *endTimeTF;
/**天数 */
@property (nonatomic, strong) BRTextField *dayNumTF;
/**请假类型数组*/
@property (nonatomic, copy) NSArray *typeArray;
/***内容*/
@property(nonatomic,strong)NSString *string;
@end

@implementation AskLeaveController

- (void)viewWillAppear:(BOOL)animated {
[super viewWillAppear:animated];
    [self updataetype];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"请假";
    self.tableView.hidden = NO;
    [self.view addSubview:self.button];
  _dataArray=@[@[@"请假类型",@ "开始日期",@"开始时间",@"结束日期",@"结束时间",@"请假天数"],@[@"请假原因"]];
}

#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, ScreenH-SK_ButtonHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UIButton *)button{
    if (!_button) {
        _button= [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenH-SK_ButtonHeight,ScreenW, SK_ButtonHeight)];
           [_button setBackgroundImage:[ZXDmethod ButtonColorLayer] forState:UIControlStateNormal];
            [_button setTitle:@"提交" forState:UIControlStateNormal];
            [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
          [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
                 
    }
    return _button;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==1) {
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
    if(indexPath.section==0){
           static NSString *cellID = @"testCell";
              UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
              if (!cell) {
                  cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
              }
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row!=5) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
              cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
        cell.textLabel.text =_dataArray[indexPath.section][indexPath.row];
    
        switch (indexPath.row) {
              case 0:
              {
             
                  [self setuptypeTF:cell];
              }
                  break;
              case 1:
              {
                  [self setupstartDateTF:cell];
              }
                  break;
              case 2:
              {
               [self setupstarTimeTF:cell];
              }
                  break;
              case 3:
              {
                   [self setupendDateTF:cell];
              
              }
                  break;
              case 4:
              {
                   [self setupendTimeTF:cell];
              }
                  break;
            case 5:
              {
                 [self setupNameTF:cell];
              }
                 break;
              default:
                  break;
          }
    return cell;
    }else{
        TextViewCell *cell =[TextViewCell      TextViewTableViewCellWithTableView:tableView];
                __weak typeof(self) weakSelf = self;
               [cell.textView didChangeText:^(PlaceholderTextView *textView) {
                      weakSelf.string=  textView.text;
                      ZLog(@"%@",textView.text);
                  }];
        cell.titleLabel.text=_dataArray[indexPath.section][indexPath.row];
      
        return cell;
    }
    
}
- (BRTextField *)getTextField:(UITableViewCell *)cell {
    BRTextField *textField = [[BRTextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 230, 0, 200, 50)];
    textField.backgroundColor = [UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:16.0f];
    textField.textAlignment = NSTextAlignmentRight;
    textField.delegate = self;
    [cell.contentView addSubview:textField];
    return textField;
}

//使cell的下划线顶头
-(void)tableView:(UITableView* )tableView willDisplayCell:(UITableViewCell* )cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
[cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
    }
}
#pragma mark - delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
}

//底部
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15 ;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, 15)];
    if (section==0) {
       headerView.backgroundColor=RGB(238, 238, 238);
    }
    return headerView;
}

#pragma mark - 请假类型 textField
- (void)setuptypeTF:(UITableViewCell *)cell {
    if (!_typeTF) {
        _typeTF = [self getTextField:cell];
        _typeTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
        _typeTF.tapAcitonBlock = ^{
            [BRStringPickerView showPickerWithTitle:@"请假类型" dataSourceArr:weakSelf.typeArray selectIndex:0 isAutoSelect:YES resultBlock:^(BRResultModel * _Nullable resultModel) {
                 weakSelf.typeTF.text = resultModel.value;
            }];
    
        };
    }
}
#pragma mark -开始时间 textField
- (void)setupstartDateTF:(UITableViewCell *)cell {
    if (!_startDateTF) {
        _startDateTF = [self getTextField:cell];
        _startDateTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
               _startDateTF.tapAcitonBlock = ^{
                   [BRDatePickerView showDatePickerWithMode:BRDatePickerModeYMD title:@"开始日期" selectValue:weakSelf.startDateTF.text isAutoSelect:YES resultBlock:^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
                       weakSelf.startDateTF.text = selectValue;
                   }];
               };
    }
}
#pragma mark - 开始时间 textField
- (void)setupstarTimeTF:(UITableViewCell *)cell {
    if (!_starTimeTF) {
        _starTimeTF = [self getTextField:cell];
        _starTimeTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
        _starTimeTF.tapAcitonBlock = ^{
            [BRDatePickerView showDatePickerWithMode:BRDatePickerModeHM title:@"开始时间" selectValue:weakSelf.starTimeTF.text isAutoSelect:YES resultBlock:^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
                weakSelf.starTimeTF.text = selectValue;
            }];
          
        };
    }
}
#pragma mark -结束日期 textField
- (void)setupendDateTF:(UITableViewCell *)cell {
    if (!_endDateTF) {
        _endDateTF = [self getTextField:cell];
        _endDateTF.placeholder = @"请选择结束日期";
        __weak typeof(self) weakSelf = self;
               _endDateTF.tapAcitonBlock = ^{
                   [BRDatePickerView showDatePickerWithMode:BRDatePickerModeYMD title:@"结束日期" selectValue:weakSelf.endDateTF.text isAutoSelect:YES resultBlock:^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
                       weakSelf.endDateTF.text = selectValue;
                   }];
               };
    }
}
#pragma mark - 结束时间 textField
- (void)setupendTimeTF:(UITableViewCell *)cell {
    if (!_endTimeTF) {
        _endTimeTF = [self getTextField:cell];
        _endTimeTF.placeholder = @"请选择结束时间";
        __weak typeof(self) weakSelf = self;
        _endTimeTF.tapAcitonBlock = ^{
            [BRDatePickerView showDatePickerWithMode:BRDatePickerModeHM title:@"结束时间" selectValue:weakSelf.endTimeTF.text isAutoSelect:YES resultBlock:^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
                weakSelf.endTimeTF.text = selectValue;
            }];
          
        };
    }
}
#pragma mark - 天数 textField
- (void)setupNameTF:(UITableViewCell *)cell {
    if (!_dayNumTF) {
        _dayNumTF = [self getTextField:cell];
        _dayNumTF.placeholder = @"请输入天数";
        _dayNumTF.returnKeyType = UIReturnKeyDone;
        _dayNumTF.keyboardType = UIKeyboardTypeDecimalPad;
        _dayNumTF.tag = 0;
    }
}

-(void)buttonClick{
    NSLog(@"%@",_dayNumTF.text);
    NSLog(@"%@",kFetchMyDefault(@"ticket"));
if(_typeTF.text!=nil&&_startDateTF.text!=nil&&_endDateTF.text!=nil&&_starTimeTF.text!=nil&&_endTimeTF.text!=nil&&_dayNumTF.text&&_string!=nil) {
    
  NSString *starString =  [NSString stringWithFormat:@"%@ %@",_startDateTF.text, _starTimeTF.text];
    NSString *endString=[NSString stringWithFormat:@"%@ %@",_endDateTF.text,_endTimeTF.text];
       NSString *urlStr =[NSString stringWithFormat:@"%@xdtapp/api/v1/flowPath/leave",kAPI_URL];
    NSDictionary *dict =@{@"ticket":   kFetchMyDefault(@"ticket"),@"flowType":_typeTF.text,@"dayNum":_dayNumTF.text,@"startTime":starString ,@"endTime":endString ,@"reasons":_string};
             
       [ZXDNetworking POST:urlStr parameters:dict success:^(id responseObject) {
       
           if ([responseObject[@"code"] intValue]==0) {
          [ELNAlerTool showAlertMassgeWithController:self andMessage:@"提交成功" andInterval:1.0];
               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             [self.navigationController popViewControllerAnimated:YES];
                         });
           }
        
       } failure:^(NSError *error) {
           
       } view:self.view];
    }
}
-(void)updataetype{
 
    NSString *urlStr =[NSString stringWithFormat:@"%@xdtapp/api/v1/flowPath/getLeaveType",kAPI_URL];
    [ZXDNetworking GET:urlStr parameters:nil success:^(id responseObject) {
        if ([responseObject[@"code"] intValue]==0) {
            NSMutableArray *arr=[NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"data"]) {
               ;
            [arr addObject: [dic objectForKey:@"flowTypeName"]];
            }
            self.typeArray=[NSArray arrayWithArray:arr];
          }
    } failure:^(NSError *error) {
        
    } view:self.view MBPro:YES];
   
}

@end
