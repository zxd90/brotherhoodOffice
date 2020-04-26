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
#import "CacheTools.h"
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
        //清除缓存
          UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"确定清除缓存吗?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
             //创建一个取消和一个确定按钮
             UIAlertAction *actionCancle=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
             //因为需要点击确定按钮后改变文字的值，所以需要在确定按钮这个block里面进行相应的操作
             UIAlertAction *actionOk=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

                 //清楚缓存
                BOOL isSuccess = [CacheTools clearCacheWithFilePath:kCachePath];
                 if (isSuccess) {
                     ZLog(@"---->清除成功");
                //刷新
                    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                    [ELNAlerTool showAlertMassgeWithController:self andMessage:@"清除成功" andInterval:1.0];
                     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            LoginViewController *loginVC=[[LoginViewController alloc]init];
                                      [self.navigationController presentViewController:loginVC animated:YES completion:^{
                                          
                                      }];
                            });
                        
                 }else{
                       ZLog(@"---->清除失败");
                 }
             }];
             //将取消和确定按钮添加进弹框控制器
             [alert addAction:actionCancle];
             [alert addAction:actionOk];
             //添加一个文本框到弹框控制器
             //显示弹框控制器
             [self presentViewController:alert animated:YES completion:nil];
    }else if(indexPath.section==3){
          kSaveMyDefault(@"asName",@"");
        LoginViewController *loginVC=[[LoginViewController alloc]init];
        [self.navigationController presentViewController:loginVC animated:YES completion:^{
            
        }];
    }
}

/**上传头像*/
-(void)mytableViewtap{
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
              if (image) {
               NSData *pictureData = UIImagePNGRepresentation(image);
                  self.Array=[NSArray arrayWithObject:pictureData];
                  NSLog(@"++++++==%@",self.Array);
                  NSString *urlStr =[NSString stringWithFormat:@"%@xdtapp/api/v1/user/updateHeadImg",kAPI_URL];
                  NSDictionary *dict =@{@"ticket": kFetchMyDefault(@"ticket")};
                  [ZXDNetworking POST:urlStr parameters:dict uploadImageArrayWithImages:self.Array imageName:@"headImg" success:^(NSDictionary *obj) {
                      if ([obj[@"code"]intValue]==0) {
                          
                        self.tableView.image.image=image;
                       [ELNAlerTool showAlertMassgeWithController:self andMessage:@"上传成功" andInterval:1.0];
                      }
                  } failure:^(NSError *error) {
                  
                  }view:self.view];
              }
          }];
}

@end
