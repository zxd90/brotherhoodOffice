//
//  DepartureController.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/8.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "DepartureController.h"
#import "BRResultModel.h"
#import "TextViewCell.h"
#import "ChopersonController.h"

@interface DepartureController ()<UITableViewDelegate,UITableViewDataSource ,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;

@property (nonatomic, strong)UIButton *button;
/**离职日期*/
@property (nonatomic, strong) BRTextField *departureTF;
/**资产交接*/
@property (nonatomic, strong) BRTextField *AssetTF;
/**资产交接内容*/
@property (nonatomic, strong) NSString *AssetStr;
@property (nonatomic, copy) NSArray *array;
/**工作交接*/
@property (nonatomic, strong) BRTextField *workTF;
/**工作交接内容*/
@property (nonatomic, strong) NSString *workStr;
/**离职内容*/
@property (nonatomic, strong) NSString *reasonStr;
/**工作交接人ID*/
@property (nonatomic, strong) NSString *workuserId;
/**资产交接人ID*/
@property (nonatomic, strong) NSString *AssetuserId;
//保存textField数据源
@property (nonatomic,strong)NSMutableDictionary*dict;
@end

@implementation DepartureController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"申请离职";
    self.tableView.hidden = NO;
    [self.view addSubview:self.button];
   _dict =[NSMutableDictionary dictionary];
 _dataArray=@[@[@"离职日期",@"资产交接人"],@[@"资产内容交接"],@[@"工作交接人"],@[@"工作内容交接"],@[@"离职原因"]];
}
#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenW , ScreenH-SK_ButtonHeight) style:UITableViewStylePlain];
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
          [_button addTarget:self action:@selector(LeaveAppButtonClick) forControlEvents:UIControlEventTouchUpInside];
                 
    }
    return _button;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0||indexPath.section==2) {
            return 50;
       }else{
          return 150;
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
    if(indexPath.section==0||indexPath.section==2){
         static NSString *cellID = @"testCell";
                   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                   if (!cell) {
                       cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                   }
              cell.selectionStyle = UITableViewCellSelectionStyleNone;
              cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
         
              cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
              cell.textLabel.text =_dataArray[indexPath.section][indexPath.row];
        if (indexPath.section==0) {
            switch (indexPath.row) {
            case 0:
                {
                [self setupdepartureTF:cell];
                }
                break;
            case 1:
                {
                [self setupAssetTF:cell];
                }
                break;
                default:
            break;
                }
        }else{
              [self setupworkTF:cell];
        }
      
          return cell;
       
    }else{
        static NSString *CellIdentifier = @"TextViewCell";
                     TextViewCell *cell = [[TextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TextViewCell"];
                       if (!cell) {
                cell=[[TextViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                       }
        cell.titleLabel.text=_dataArray[indexPath.section][indexPath.row];
        cell.textView.text=_dict[[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak typeof(self) weakSelf = self;
        [cell.textView didChangeText:^(PlaceholderTextView *textView) {
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            //保存数据源
            [weakSelf.dict setObject:textView.text forKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];;
              switch (indexPath.section) {
                     case 1:
                    weakSelf.AssetStr= textView.text;
                         break;
                     case 3:
                       weakSelf.workStr= textView.text;
                         break;
                      case 4:
                    weakSelf.reasonStr= textView.text;
                         break;
                     default:
                         break;
                 }
           
          
            
        }];
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
    if (section!=4) {
       headerView.backgroundColor=RGB(238, 238, 238);
    }
    return headerView;
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

#pragma mark -开始时间 textField
- (void)setupdepartureTF:(UITableViewCell *)cell {
    if (!_departureTF) {
        _departureTF = [self getTextField:cell];
        _departureTF.placeholder = @"请选择";
        __weak typeof(self) weakSelf = self;
              _departureTF.tapAcitonBlock = ^{
                   [BRDatePickerView showDatePickerWithMode:BRDatePickerModeYMD title:@"开始日期" selectValue:weakSelf.departureTF.text isAutoSelect:YES resultBlock:^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
                       weakSelf.departureTF.text = selectValue;
                   }];
               };
    }
}
#pragma mark -资产工作 textField
- (void)setupAssetTF:(UITableViewCell *)cell {
    if (!_AssetTF) {
        _AssetTF = [self getTextField:cell];
        _AssetTF.placeholder = @"请选择资产交接人";
    __weak typeof(self) weakSelf = self;
        _AssetTF.tapAcitonBlock = ^{
             ChopersonController *cheopVC=[[ChopersonController alloc]init];
                     cheopVC.num= 0;
                     cheopVC.blcokFriendStr=^(FriendModel *Friend){
                        weakSelf.AssetTF.text = Friend.userName;
                        weakSelf.AssetuserId=[NSString stringWithFormat:@"%d", Friend.userId];
                     };
             [weakSelf.navigationController pushViewController:cheopVC animated:YES];
                  };
    }
}
#pragma mark -工作交接 textField
- (void)setupworkTF:(UITableViewCell *)cell {
    if (!_workTF) {
        _workTF = [self getTextField:cell];
        _workTF.placeholder = @"请选择工作交接人";
        __weak typeof(self) weakSelf = self;
                _workTF.tapAcitonBlock = ^{
            ChopersonController *cheopVC=[[ChopersonController alloc]init];
            cheopVC.num= 1;
            cheopVC.blcokworkStr=^(FriendModel *Friend){
                    weakSelf.workTF.text = Friend.userName;
                    weakSelf.workuserId=[NSString stringWithFormat:@"%d", Friend.userId];
                         };
                     [weakSelf.navigationController pushViewController:cheopVC animated:YES];
                };
    }
}
-(void)LeaveAppButtonClick{
    
    NSString *urlStr =[NSString stringWithFormat:@"%@xdtapp/api/v1/quit/doQuit",kAPI_URL];
    NSDictionary *dict =@{@"ticket":   kFetchMyDefault(@"ticket"),@"quitTime":_departureTF.text,@"quitReason":self.reasonStr,@"assetsUserId": self.AssetuserId,@"assetsMsg": self.AssetStr,@"workUserId":self.workuserId ,@"workMsg":self.workStr};
   
         [ZXDNetworking  POST:urlStr parameters:dict success:^(id responseObject) {
         
             if ([responseObject[@"code"] intValue]==0) {
             [ELNAlerTool showAlertMassgeWithController:self andMessage:@"提交成功" andInterval:1.0];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                           });
             }
          
         } failure:^(NSError *error) {
             
         } view:self.view];
}



@end
