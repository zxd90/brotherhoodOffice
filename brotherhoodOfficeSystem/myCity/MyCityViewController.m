//
//  MyCityViewController.m
//  brotherhoodMall
//
//  Created by 费腾 on 2020/3/18.
//  Copyright © 2020 兄弟团国际. All rights reserved.
//

#import "MyCityViewController.h"
#import "mytableView.h"
#import "BDImagePicker.h"
#import "ModifyController.h"
@interface MyCityViewController ()<mytableViewDelegate>
@property (nonatomic, strong)mytableView *tableView;
@property (nonatomic, copy)NSArray *Array;
@end

@implementation MyCityViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
      [self.view setBackgroundColor:[UIColor whiteColor]];
   _tableView = [[mytableView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, ScreenH-SK_TabbarSafeBottomMargin)];
       _tableView.mytableDelegate = self;
    [self.view addSubview:_tableView];
}
-(void)tableViewsection:(UITableView *)tableView mytableViewClick:(NSIndexPath*)indexPath{
  
    if(indexPath.section==2){
        ModifyController *ModifyCV=[[ModifyController alloc]init];
        [self.navigationController pushViewController:ModifyCV animated:YES];
    }else if(indexPath.section==1&&indexPath.row==0){
       //刷新
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

        //清除缓存
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"是否清理缓存？"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定", nil];
        alertView.tag = 1011;
        [alertView show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1 && alertView.tag == 1011) {
       
        
    }
}
-(void)mytableViewtap{
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
              if (image) {
                  self.tableView.image.image=image;
               NSData *pictureData = UIImagePNGRepresentation(image);
                  self.Array=[NSArray arrayWithObject:pictureData];
                  NSString *urlStr =[NSString stringWithFormat:@"%@xdtapp/api/v1/user/updateHeadImg",kAPI_URL];
                  NSDictionary *dict =@{@"ticket": kFetchMyDefault(@"ticket")};
                  [ZXDNetworking POST:urlStr parameters:dict uploadImageArrayWithImages:self.Array success:^(NSDictionary *obj) {
                      if ([obj[@"code"]intValue]==0) {
                          
                          
                      }
                  } failure:^(NSError *error) {
                  
                  }view:self.view];
              }
          }];
}

@end
