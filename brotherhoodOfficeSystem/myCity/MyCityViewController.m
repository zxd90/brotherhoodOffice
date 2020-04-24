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
    mytableView *tableView = [[mytableView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, ScreenH-SK_TabbarSafeBottomMargin)];
       tableView.mytableDelegate = self;
    [self.view addSubview:tableView];
}
-(void)tableViewsection:(NSInteger)section mytableViewClick:(NSInteger)tag{
    
    
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
