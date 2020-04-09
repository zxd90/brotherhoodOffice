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
    _passWordText.secureTextEntry = YES;
    [self.view addSubview:_passWordText];
    [_passWordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_accoutText.mas_bottom).offset(5);
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
    [_loginBut setBackgroundImage:[self ButtonColorLayer] forState:UIControlStateNormal];
//    _loginBut.backgroundColor =RGBA(66, 153, 16, 1);
    [_loginBut addTarget:self action:@selector(login_btn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBut];
    [_loginBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_passWordText.mas_bottom).offset(80);
        make.left.equalTo(self.view.mas_left).offset(47.5);
        make.right.equalTo(self.view.mas_right).offset(-47.5);;
        make.height.offset(50);
    }];


}
-(void)login_btn{
    ZDLog(@"%@", self.accoutText.text);
    ZDLog(@"%@", self.passWordText.text);
    
    NNTabBarController   *NNTab  = [[NNTabBarController alloc] init];
    NNTab.modalTransitionStyle =UIModalTransitionStyleCrossDissolve ;
      UIWindow *window = [UIApplication sharedApplication].delegate.window;
      window.rootViewController = NNTab;
}


-(UIImage *)ButtonColorLayer{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(20, 0, ScreenW-40, 50);  // 设置显示的frame
    gradientLayer.colors = @[(id)RGBA(66, 153, 16, 1).CGColor,(id)RGBA(78, 195, 11, 1).CGColor];  // 设置渐变颜色
    gradientLayer.locations = @[@0.0,@0.7];    // 颜色的起点位置，递增，并且数量跟颜色数量相等
    gradientLayer.startPoint = CGPointMake(0, 0);   //
    gradientLayer.endPoint = CGPointMake(1, 0);
    UIGraphicsBeginImageContext(gradientLayer.frame.size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}
@end
