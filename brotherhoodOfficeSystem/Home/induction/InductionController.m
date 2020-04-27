//
//  InductionController.m
//  brotherhoodOfficeSystem
//
//  Created by 费腾 on 2020/4/8.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "InductionController.h"
#import "inductionCell.h"
#import "BDImagePicker.h"
@interface InductionController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, copy) NSArray *textArray;
@property (nonatomic, strong)UIButton *button;
/**姓名*/
@property (nonatomic,strong)NSString *name;
/**电话*/
@property (nonatomic,strong)NSString *phone;
/**身份证*/
@property (nonatomic,strong)NSString *idCard;
/**原居住地地址*/
@property (nonatomic,strong)NSString *idAddress;
/**地址*/
@property (nonatomic,strong)NSString *address;
/**紧急联系人*/
@property (nonatomic,strong)NSString *urgentPeople;
/**紧急联系人电话*/
@property (nonatomic,strong)NSString *urgentPhoneNumber;
/**关系*/
@property (nonatomic,strong)NSString *forMe;
@property (nonatomic, copy) NSArray *Array;
@property (nonatomic, copy)NSMutableArray *Array1;
//保存textField数据源
@property (nonatomic,strong)NSMutableDictionary*dict;
@end

@implementation InductionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"入职";
    self.tableView.hidden = NO;
        [self.view addSubview:self.button];
    _Array=[NSArray array];
     _Array1=[NSMutableArray array];
   _dict =[NSMutableDictionary dictionary]; _dataArray=@[@"姓名",@"联系方式",@"身份证号",@"户籍所在地",@"现居住地址",@"紧急联系人",@"紧急联系人电话",@"与本人关系"];
    _textArray=@[@"请输入姓名", @"请输入手机号",@"请填写身份证号",@"请填写户籍所在地",@"请填写现居地址",@"请填写紧急联系人",@"请填写紧急联系人电话",@"请填写与本人关系"];
}

#pragma mark - lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, ScreenH-SK_ButtonHeight) style:UITableViewStylePlain];
        _tableView.tableFooterView=[self subHeaderView];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 100;
        _tableView.rowHeight = UITableViewAutomaticDimension;
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
          [_button addTarget:self action:@selector(entrySubmission) forControlEvents:UIControlEventTouchUpInside];
                 
    }
    return _button;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//  return 50;
//
//}
#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
           static NSString *CellIdentifier = @"inductionCell";
            inductionCell *cell = [[inductionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                if (!cell) {
                    cell = [[inductionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
            cell.titleLabel.text=_dataArray[indexPath.row];
           
            cell.textView.text=_dict[[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    if ([_dict[[NSString stringWithFormat:@"%ld",(long)indexPath.row]]length]==0) {
         cell.placeholderLabel.text =_textArray[indexPath.row];
    }
            cell.textView.delegate=self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
           
            return cell;
      
    
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

-(void)textViewDidChange:(UITextView *)textView{
    inductionCell *cell = (inductionCell *)[textView superview].superview;
       NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (textView.text.length==0) {
        cell.placeholderLabel.hidden=NO;
      } else {
          cell.placeholderLabel.hidden=YES;
      }
    CGRect frame = textView.frame;
      CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
      CGSize size = [textView sizeThatFits:constraintSize];
      if (size.height<=frame.size.height) {
          size.height=frame.size.height;
      }
    NSLog(@"=======%@",self.name);
    //保存数据源
    [_dict setObject:textView.text forKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];;
    switch (indexPath.row) {
           case 0:
               self.name = textView.text;
               break;
           case 1:
               self.phone = textView.text;
               break;
               case 2:
                self.idCard = textView.text;
               break;
               case 3:
                self.idAddress = textView.text;
                break;
               case 4:
               self.address = textView.text;
                break;
               case 5:
                self.urgentPeople = textView.text;
                break;
                case 6:
                self.urgentPhoneNumber = textView.text;
                break;
                case 7:
                self.forMe = textView.text;
                break;
           default:
               break;
       }
 
     cell.textView.frame = CGRectMake(frame.origin.x, frame.origin.y,cell.contentView.frame.size.width, size.height);
     
     [self.tableView beginUpdates];
     [self.tableView endUpdates];

}



//底部
-(CGFloat)tableView:(UITableView *)tableView heightForFooSterInection:(NSInteger)section{
    return (ScreenW-80)/2.8+80;
}


-(void)buttonUploadPhoto:(UIButton *)sender{
   
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        
        
           if (image) {
            [sender setBackgroundImage:image forState:UIControlStateNormal];
            NSData *pictureData = UIImagePNGRepresentation(image);
               [self.Array1 addObject:pictureData];
           }
       }];
}

-(UIView *)subHeaderView{
  
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenW,(ScreenW-80)/2.8+80)];
       UIView * View = [[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, 15)];
         View.backgroundColor=RGB(238, 238, 238);
        [headerView addSubview:View];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15,View.bottom+10 ,200 ,20)];
        label.text=@"上传身份证正反面照片";
        label.font=[UIFont systemFontOfSize:16.0];
        [headerView addSubview:label];
    for (int i=0; i<2; i++) {
        UIButton *button= [UIButton buttonWithType:UIButtonTypeCustom];
               button.frame=CGRectMake(i*(ScreenW/2)+20, label.bottom+10,(ScreenW/2-40),(ScreenW-80)/2.8);
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"renxiang%d",i]] forState:UIControlStateNormal];
               [button addTarget:self action:@selector(buttonUploadPhoto:) forControlEvents:UIControlEventTouchUpInside];
               [headerView addSubview:button];
       }
    return headerView;
}
-(void)entrySubmission{
   self.dataArray = [NSArray arrayWithArray:self.Array1];
    NSString *urlStr =[NSString stringWithFormat:@"%@xdtapp/api/v1/entry/doEntry",kAPI_URL];
    NSDictionary *dict =@{@"ticket":   kFetchMyDefault(@"ticket"),@"realName":self.name,@"phoneNumber":self.phone,@"idCard":self.idCard ,@"idAddress":self.idAddress ,@"address":self.address,@"urgentPeople":self.urgentPeople,@"urgentPhoneNumber":self.urgentPhoneNumber,@"forMe":self.forMe};
    [ZXDNetworking POST:urlStr parameters:dict uploadImageArrayWithImages:self.dataArray imageName:@"idCards" success:^(NSDictionary *obj) {
        if ([obj[@"code"]intValue]==0) {
    [ELNAlerTool showAlertMassgeWithController:self andMessage:@"提交成功" andInterval:1.0];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    } failure:^(NSError *error) {
    
    }view:self.view];
}

@end
