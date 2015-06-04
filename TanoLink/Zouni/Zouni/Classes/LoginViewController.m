//
//  LoginViewController.m
//  登录页面
//
//  Created by aokuny on 15/6/1.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "LoginViewController.h"
#import "MyInfoViewController.h"
//#import "ZNBaseNavigationController.h"

@interface LoginViewController (){
    UIImageView *iconUserName;
    UIImageView *iconPwd;
    UITextField *accountTextField;
    UITextField *passwordTextField;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    [self setTitle:@"登录"];
    [self.view setBackgroundColor:ZN_BACKGROUND_COLOR];

    [self setRightBarButtonItemTitle:@"注册" target:self action:@selector(doRegister)];
    [accountTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [accountTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    
}

-(void)loadView {
    [super loadView];
    UIView *cellBackGroundView = [[UIView alloc]initWithFrame:CGRectZero];
    cellBackGroundView.layer.borderColor = ZN_BORDER_LINE_COLOR.CGColor;
    cellBackGroundView.layer.borderWidth = 0.5f;
    [cellBackGroundView setBackgroundColor:[UIColor whiteColor]];
    iconUserName = [[UIImageView alloc]initWithFrame:CGRectZero];
    [iconUserName setImage:[UIImage imageNamed:@"name_icon"]];

    accountTextField = [[UITextField alloc]initWithFrame:CGRectZero];
    [accountTextField setDelegate:self];
    [accountTextField setTextColor:ZN_FONNT_01_BLACK];
    [accountTextField setFont:DEFAULT_FONT(14)];
    [accountTextField setPlaceholder:@"请输入您的账号"];
    [cellBackGroundView addSubview:iconUserName];
    [cellBackGroundView addSubview:accountTextField];
    [self.view addSubview:cellBackGroundView];
    
    [cellBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(18);
        make.height.equalTo(@44);
        make.width.equalTo(self.view);
        make.left.equalTo(self.view);
    }];
    [iconUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cellBackGroundView).offset(10);
        make.centerY.equalTo(cellBackGroundView);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconUserName.mas_right).offset(10);
        make.right.equalTo(cellBackGroundView);
        make.centerY.equalTo(cellBackGroundView);
        make.height.equalTo(@30);
    }];
    
    // 密码
    UIView *cellBackGroundViewPWd = [[UIView alloc]initWithFrame:CGRectZero];
    cellBackGroundViewPWd.layer.borderColor = ZN_BORDER_LINE_COLOR.CGColor;
    cellBackGroundViewPWd.layer.borderWidth = 0.5f;
    [cellBackGroundViewPWd setBackgroundColor:[UIColor whiteColor]];
    iconPwd = [[UIImageView alloc]initWithFrame:CGRectZero];
    [iconPwd setImage:[UIImage imageNamed:@"pw_icon"]];
    passwordTextField = [[UITextField alloc]initWithFrame:CGRectZero];
    [passwordTextField setDelegate:self];
    [passwordTextField setTextColor:ZN_FONNT_01_BLACK];
    [passwordTextField setFont:DEFAULT_FONT(14)];
    passwordTextField.secureTextEntry = YES;
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [cellBackGroundViewPWd addSubview:iconPwd];
    [cellBackGroundViewPWd addSubview:passwordTextField];
    [self.view addSubview:cellBackGroundViewPWd];
    [cellBackGroundViewPWd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cellBackGroundView.mas_bottom).offset(-0.5f);
        make.height.equalTo(@44);
        make.width.equalTo(self.view);
        make.left.equalTo(self.view);
    }];
    [iconPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconUserName);
        make.centerY.equalTo(cellBackGroundViewPWd);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconPwd.mas_right).offset(10);
        make.right.equalTo(cellBackGroundViewPWd);
        make.centerY.equalTo(cellBackGroundViewPWd);
        make.height.equalTo(@30);
    }];
    passwordTextField.placeholder = @"请输入账户密码";
    
    UIButton *btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLogin.layer.cornerRadius = 6;
    [btnLogin setTitle:@"登   录" forState:UIControlStateNormal];
    [btnLogin.titleLabel setFont:DEFAULT_FONT(15)];
    [btnLogin.titleLabel setTextColor:[UIColor whiteColor]];
    [btnLogin setBackgroundColor:ZN_FONNT_04_ORANGE];
    [btnLogin addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];
    [btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cellBackGroundViewPWd.mas_bottom).offset(15);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(self.view.frame.size.width-40));
        make.height.equalTo(@40);
    }];
    
    UIButton *getPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getPwdBtn.titleLabel.font = DEFAULT_FONT(14);
    [getPwdBtn setTitle:@"忘记密码 ?" forState:UIControlStateNormal];
    [getPwdBtn setTitleColor:RGBCOLOR(28,161,230) forState:UIControlStateNormal];
    [getPwdBtn setTitleColor:[UIColor colorWithWhite:0.805 alpha:1.000] forState:UIControlStateHighlighted];
    [getPwdBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [getPwdBtn sizeToFit];
    [getPwdBtn addTarget:self action:@selector(retakePassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getPwdBtn];
    
    [getPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnLogin.mas_bottom).offset(10);
        make.right.equalTo(btnLogin.mas_right);
        make.width.equalTo(@120);
        make.height.equalTo(@30);
    }];
    
    UIView *party3LoginView = [self party3LoginView];
//    [self.view addSubview:party3LoginView];
    [party3LoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@90);
    }];

    UIView *lineLabelView2 = [self lineLabelView:@"使用第三方账号登录" bounds:CGRectMake(20.f, 20.f+ kTopNavBarMargin, CGRectGetWidth(self.view.frame) - 40.f, 20)];
    [self.view addSubview:lineLabelView2];
    [lineLabelView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(party3LoginView.mas_top).offset(-10);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@20);
        make.width.equalTo(@(self.view.frame.size.width-40));
    }];
    
    
}

-(UIView *)lineLabelView : (NSString *)labelStr bounds:(CGRect)bounds{
    UIView *view = [[UIView alloc]initWithFrame:bounds];
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.text = labelStr;
    label.textColor = ZN_FONNT_02_GRAY;
    label.font = DEFAULT_FONT(12);
    [label sizeToFit];
    
    label.frame = CGRectMake((bounds.size.width-label.frame.size.width)/2,( bounds.size.height-label.frame.size.height)/2, label.frame.size.width, label.frame.size.height);
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0,( bounds.size.height - 1)/2 , CGRectGetMinX(label.frame)-5, .5)];
    lineView1.backgroundColor = ZN_FONNT_03_LIGHTGRAY;
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+5, ( bounds.size.height - 1)/2 , bounds.size.width- CGRectGetMaxX(label.frame)-5, .5)];
    lineView2.backgroundColor = ZN_FONNT_03_LIGHTGRAY;
    [view addSubview:lineView1];
    [view addSubview:lineView2];
    [view addSubview:label];
    
    return view;
}

-(UIView *)party3LoginView {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    [view setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:view];
//    CGRect btnBounds =CGRectMake(0, 0, (CGRectGetWidth(self.view.frame) - 40*4.f) / 3, CGRectGetHeight(view.bounds));
//    UIButton *iconBtn1 = [UIButton buttonWithBounds:btnBounds iconImage:@"share_weibo" iconTitle:@"微博登录"];
//    iconBtn1.frame = CGRectOffset(btnBounds, 20, 0);
//    iconBtn1.tag = 1;
//    [iconBtn1 addTarget:self action:@selector(loginThirdPartyAction:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton *iconBtn2 = [UIButton buttonWithBounds:btnBounds iconImage:@"share_weixin" iconTitle:@"微信登录"];
//    iconBtn2.tag = 2;
//    iconBtn2.frame = CGRectOffset(btnBounds, CGRectGetMaxX(iconBtn1.frame) + 20.f, 0);
//    [iconBtn2 addTarget:self action:@selector(loginThirdPartyAction:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton *iconBtn3 = [UIButton buttonWithBounds:btnBounds iconImage:@"share_qq" iconTitle:@"QQ登录"];
//    iconBtn3.tag = 3;
//    iconBtn3.frame = CGRectOffset(btnBounds, CGRectGetMaxX(iconBtn2.frame) + 20.f, 0);
//    [iconBtn3 addTarget:self action:@selector(loginThirdPartyAction:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *iconBtn1 = [UIButton new];
    [iconBtn1 setImage:[UIImage imageNamed:@"share_weibo"] forState:UIControlStateNormal];
    UIButton *iconBtn2 = [UIButton new];
    [iconBtn2 setImage:[UIImage imageNamed:@"share_weixin"] forState:UIControlStateNormal];
    UIButton *iconBtn3= [UIButton new];
    [iconBtn3 setImage:[UIImage imageNamed:@"share_qq"] forState:UIControlStateNormal];
    
    [view addSubview:iconBtn1];
    [view addSubview:iconBtn2];
    [view addSubview:iconBtn3];
    
    [iconBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset((self.view.frame.size.width-40*3)/4);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
        make.centerY.equalTo(view).offset(-10);
    }];
    [iconBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@40);
        make.height.equalTo(@40);
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(iconBtn1);
    }];
    [iconBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-(self.view.frame.size.width-40*3)/4);
        make.bottom.equalTo(iconBtn1);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
        make.centerY.equalTo(iconBtn1);
    }];
    
    return view;
}

#pragma mark - action
-(void)loginThirdPartyAction : (UIButton *) button{
    NSLog(@"%ld", (long)button.tag);
}

-(void)loginBtnAction : (UIButton *)button {
    [self.view endEditing:YES];
    if (!accountTextField.text.length) {
//        [JGProgressHUD showHintStr:@"登录账号不能为空"];
        ViewShaker *shakAccount = [[ViewShaker alloc]initWithViewsArray:@[iconUserName,accountTextField]];
        [shakAccount shake];
        return;
    }
    if (!passwordTextField.text.length) {
//        [JGProgressHUD showHintStr:@"密码不能为空"];
        ViewShaker *shakPwd = [[ViewShaker alloc]initWithViewsArray:@[iconPwd,passwordTextField]];
        [shakPwd shake];
        return;
    }
    [self showHudInView:self.view hint:loadingHintStr];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:@"loginState"];
    [userDefaults synchronize];
    
    MyInfoViewController *myInfo = [MyInfoViewController new];
    [self.navigationController pushViewController:myInfo animated:YES];
    
}

-(void)doRegister {
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(void)loginAndGetUserInfo {
    
}
-(void)retakePassword {
    RetakePasswordViewController *retakePasswordVC =[[RetakePasswordViewController alloc]init];
    [self.navigationController pushViewController:retakePasswordVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
