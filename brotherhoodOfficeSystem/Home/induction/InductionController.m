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
@interface InductionController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, copy) NSArray *textArray;
@property (nonatomic, strong)UIButton *button;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *phone;
@property (nonatomic,strong)NSString *num;
@property (nonatomic,strong)NSString *household;
@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *Nowhouse;
@property (nonatomic,strong)NSString *emergency;
@end

@implementation InductionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"入职";
    self.tableView.hidden = NO;
        [self.view addSubview:self.button];
    _dataArray=@[@"姓名",@"联系方式",@"身份证号",@"户籍所在地",@"现居住地址",@"紧急联系人",@"紧急联系人电话",@"与本人关系"];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  return 50;

}
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
            cell.textField.placeholder =_textArray[indexPath.row];
            cell.textField.delegate=self;
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

- (void)textFieldDidEndEditing:(UITextField *)textField{
    inductionCell *cell = (inductionCell *)[textField superview].superview;
       NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    switch (indexPath.row) {
           case 0:
               self.name = textField.text;
               break;
           case 1:
               self.phone = textField.text;
               break;
               
           default:
               break;
       }
}



//底部
-(CGFloat)tableView:(UITableView *)tableView heightForFooSterInection:(NSInteger)section{
    return (ScreenW-80)/2.8+80;
}


-(void)buttonUploadPhoto:(UIButton *)sender{
    NSLog(@"123214342");
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
           if (image) {
               [sender setBackgroundImage:image forState:UIControlStateNormal];
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
    NSLog(@"%@",self.name);
}

@end
