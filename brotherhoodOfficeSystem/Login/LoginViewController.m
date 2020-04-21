//
//  LoginViewController.m
//  brotherhoodOfficeSystem
//  Created by 费腾 on 2020/4/7.
//  Copyright © 2020 兄弟团国际. All rights reserved.


#import "LoginViewController.h"
#import "loginTextField.h"
#import "NNTabBarController.h"
@interface LoginViewController ()
@property(nonatomic,strong) UIImageView *logoImage;
@property(nonatomic,strong) loginTextField  *accoutText;
@property(nonatomic,strong) loginTextField *passWordText;
@property(nonatomic,strong) UIButton  *loginBut;
@property(nonatomic,assign)int NUM;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self suerpView];
}
-(void)suerpView{
    UILabel *labe=[[UILabel alloc]initWithFrame:CGRectMake(ScreenW/2-18,StatusBarHeight+14, 36, 20)];
    labe.textColor =RGBA(51, 51, 51, 1);
    labe.text =@"登录";
    [self.view addSubview:labe];
    _logoImage = [[UIImageView alloc]init];
    _logoImage.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:_logoImage];
    [_logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_centerX).offset(-107);
        make.top.equalTo(labe.mas_bottom).offset(100);
        make.width.offset(212.5);
        make.height.offset(173);
    }];
    _accoutText = [[loginTextField  alloc]init];
    _accoutText.placeholder = @"用户名";
    //self.accoutText.text=@"本部门员工";
    self.accoutText.text=@"中腾";
    _accoutText.font =PFR17Font;
    [self.view addSubview:_accoutText];
    [_accoutText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_logoImage.mas_bottom).offset(50);
        make.left.equalTo(self.view.mas_left).offset(47.5);
        make.right.equalTo(self.view.mas_right).offset(-47.5);;
        make.height.offset(40);
    }];
    _passWordText = [[loginTextField  alloc]init];
    _passWordText.font =PFR17Font;
    _passWordText.placeholder = @"密码";
    self.passWordText.text=@"123";
    _passWordText.secureTextEntry = YES;
    [self.view addSubview:_passWordText];
    [_passWordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accoutText.mas_bottom).offset(5);
        make.left.equalTo(self.view.mas_left).offset(47.5);
        make.right.equalTo(self.view.mas_right).offset(-47.5);;
        make.height.offset(40);
    }];
    _loginBut = [[UIButton alloc]init];
    _loginBut.titleLabel.font =PFR17Font;
    [_loginBut.layer setMasksToBounds:YES];
    [_loginBut.layer setCornerRadius:5.0];
    [_loginBut setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBut setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [_loginBut setBackgroundImage:[ZXDmethod loginColorLayer] forState:UIControlStateNormal];
//    _loginBut.backgroundColor =RGBA(66, 153, 16, 1);
    [_loginBut addTarget:self action:@selector(login_btn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBut];
    [_loginBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passWordText.mas_bottom).offset(80);
        make.left.equalTo(self.view.mas_left).offset(47.5);
        make.right.equalTo(self.view.mas_right).offset(-47.5);;
        make.height.offset(50);
    }];


}
-(void)login_btn{
    ZLog(@"%@",self.accoutText.text );
    ZLog(@"%@",self.passWordText.text);
       
    if (self.accoutText.text==nil&& self.passWordText.text==nil) {
          [ELNAlerTool showAlertMassgeWithController:self andMessage:@"请输入用户名和密码" andInterval:1.0];
          return;
      }else if (self.passWordText.text==nil){
          [ELNAlerTool showAlertMassgeWithController:self andMessage:@"请输入密码" andInterval:1.0];
          return;

        ;
      }else if (self.accoutText.text==nil){
          [ELNAlerTool showAlertMassgeWithController:self andMessage:@"请输入用户名" andInterval:1.0];
          return;
      }else{
        
    NSString *urlStr =[NSString stringWithFormat:@"%@xdtapp/api/v1/login/doLogin",kAPI_URL];
          NSDictionary *dict     =@{@"userName":self.accoutText.text,@"password": self.passWordText.text};
           self.NUM = 0;
    [ZXDNetworking POST:urlStr parameters:dict success:^(id responseObject) {
    
        if ([responseObject[@"code"] intValue]==0) {
   
                 kSaveMyDefault(@"ticket",responseObject[@"data"][@"ticket"]);
              kSaveMyDefault(responseObject[@"data"][@"roleName"],@"roleName");
            kSaveMyDefault(responseObject[@"data"][@"roleName"],@"roleName");
        NNTabBarController   *NNTab  = [[NNTabBarController alloc] init];
                                     NNTab.modalTransitionStyle =UIModalTransitionStyleCrossDissolve ;
                                       UIWindow *window = [UIApplication sharedApplication].delegate.window;
                                       window.rootViewController = NNTab;
        }
      
     
    } failure:^(NSError *error) {
        
    } view:self.view];
    
  }
}



@end
