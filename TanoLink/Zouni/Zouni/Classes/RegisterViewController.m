//
//  RegisterViewController.m
//  注册
//
//  Created by aokuny on 15/6/1.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "RegisterViewController.h"
#import "ZNAppUtil.h"
#import "ViewShaker.h"
#import <AudioToolbox/AudioToolbox.h>
#import "RegisterSuccessViewController.h"
#import "TopTabBar.h"

@interface RegisterViewController (){
    UIView *headerView;
    
    UIImageView *iconEmail;
    UIImageView *iconCaptch;
    UIImageView *iconPwd;
    
    UITextField *_txfMobile;
    UITextField *_txfCaptch;
    UITextField *_txfPwd;
    
    UIView *_mobileViewContoller;
    UIView *_emailViewController;
}
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIButton *getCaptchButton;
@end
static SystemSoundID shake_sound_id = 0;
@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    if (self.isRemakePwd) {
        [self setTitle:@"找回密码"];
    }else{
        [self setTitle:@"注册"];
    }
    [self initTBar];
    [self buildMobileUI];
    [self buildEmailUI];
    _emailViewController.hidden = NO;
    _mobileViewContoller.hidden = YES;
}
#pragma mark - 初始化筛选栏
-(void)initTBar{
    float _barheight = 40;
    NSArray *ctbData = @[@[@"手机注册",@""],@[@"邮箱注册",@""]];
    headerView = [[TopTabBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,_barheight) andArrData:ctbData bSpera:YES andBlock:^(NSUInteger idx) {
        if (idx == 1000) {
            // 手机注册
            _emailViewController.hidden = YES;
            _mobileViewContoller.hidden = NO;
        } else if(idx == 1001){
            // 邮箱注册
            _emailViewController.hidden = NO;
            _mobileViewContoller.hidden = YES;
        }
    }];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(@40);
    }];
}
-(void)buildMobileUI{
    _count=  60;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(backTime:) userInfo:nil repeats:YES];
    [_timer setFireDate:[NSDate distantFuture]];//定时器关闭
    
    [self.view setBackgroundColor:ZN_BACKGROUND_COLOR];
    _mobileViewContoller = [UIView new];
    [self.view addSubview:_mobileViewContoller];
    [_mobileViewContoller mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom).offset(5);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    UIView *cellBackGroundView = [[UIView alloc]initWithFrame:CGRectZero];
    cellBackGroundView.layer.borderColor = ZN_BORDER_LINE_COLOR.CGColor;
    cellBackGroundView.layer.borderWidth = 0.5f;
    [cellBackGroundView setBackgroundColor:[UIColor whiteColor]];
    
    iconEmail = [[UIImageView alloc]initWithFrame:CGRectZero];
    [iconEmail setImage:[UIImage imageNamed:@"phone_icon"]];
    
    _txfMobile = [[UITextField alloc]initWithFrame:CGRectZero];
    [_txfMobile setDelegate:self];
    [_txfMobile setTextColor:ZN_FONNT_01_BLACK];
    [_txfMobile setFont:DEFAULT_FONT(14)];
    [_txfMobile setPlaceholder:@"请输入您的手机账号"];
    [_txfMobile setText:@""];
    
    [cellBackGroundView addSubview:iconEmail];
    [cellBackGroundView addSubview:_txfMobile];
    [_mobileViewContoller addSubview:cellBackGroundView];
    
    [cellBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom).offset(10);
        make.height.equalTo(@44);
        make.width.equalTo(self.view);
    }];
    [iconEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cellBackGroundView).offset(10);
        make.centerY.equalTo(cellBackGroundView);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [_txfMobile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconEmail.mas_right).offset(10);
        make.centerY.equalTo(cellBackGroundView);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
    }];
    
    // 验证码
    UIView *cellBackGroundViewCaptch = [[UIView alloc]initWithFrame:CGRectZero];
    cellBackGroundViewCaptch.layer.borderColor = ZN_BORDER_LINE_COLOR.CGColor;
    cellBackGroundViewCaptch.layer.borderWidth = 0.5f;
    [cellBackGroundViewCaptch setBackgroundColor:[UIColor whiteColor]];
    
    iconCaptch = [[UIImageView alloc]initWithFrame:CGRectZero];
    [iconCaptch setImage:[UIImage imageNamed:@"code_icon"]];
    
    _txfCaptch = [[UITextField alloc]initWithFrame:CGRectZero];
    [_txfCaptch setDelegate:self];
    [_txfCaptch setTextColor:ZN_FONNT_01_BLACK];
    [_txfCaptch setFont:DEFAULT_FONT(14)];
    [cellBackGroundViewCaptch addSubview:_txfCaptch];
    [cellBackGroundViewCaptch addSubview:iconCaptch];
    [_mobileViewContoller addSubview:cellBackGroundViewCaptch];
    [cellBackGroundViewCaptch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cellBackGroundView.mas_bottom).offset(-0.5f);
        make.height.equalTo(@44);
        make.width.equalTo(self.view);
    }];
    [iconCaptch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cellBackGroundViewCaptch).offset(10);
        make.centerY.equalTo(cellBackGroundViewCaptch);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [_txfCaptch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconCaptch.mas_right).offset(10);
        make.centerY.equalTo(cellBackGroundViewCaptch);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
    }];
    _txfCaptch.placeholder = @"请输入邮箱中的验证码";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = 2;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(getCapthcActionMobile:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    button.titleLabel.font = DEFAULT_FONT(14);
    button.layer.cornerRadius = 4;
    [button setBackgroundColor:ZN_FONNT_04_ORANGE];
    [cellBackGroundViewCaptch addSubview:button];
    self.getCaptchButton  = button;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cellBackGroundViewCaptch).offset(-10);
        make.width.equalTo(@90);
        make.height.equalTo(@30);
        make.centerY.equalTo(cellBackGroundViewCaptch);
    }];
    
    // 密码
    UIView *cellBackGroundViewPwd = [[UIView alloc]initWithFrame:CGRectZero];
    cellBackGroundViewPwd.layer.borderColor = ZN_BORDER_LINE_COLOR.CGColor;
    cellBackGroundViewPwd.layer.borderWidth = 0.5f;
    [cellBackGroundViewPwd setBackgroundColor:[UIColor whiteColor]];
    iconPwd = [[UIImageView alloc]initWithFrame:CGRectZero];
    [iconPwd setImage:[UIImage imageNamed:@"pw_icon"]];
    
    _txfPwd = [[UITextField alloc]initWithFrame:CGRectZero];
    [_txfPwd setDelegate:self];
    [_txfPwd setTextColor:ZN_FONNT_01_BLACK];
    [_txfPwd setFont:DEFAULT_FONT(14)];
    [cellBackGroundViewPwd addSubview:_txfPwd];
    [cellBackGroundViewPwd addSubview:iconPwd];
    [_mobileViewContoller addSubview:cellBackGroundViewPwd];
    [cellBackGroundViewPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cellBackGroundViewCaptch.mas_bottom).offset(-0.5f);
        make.height.equalTo(@44);
        make.width.equalTo(self.view);
    }];
    [iconPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cellBackGroundViewCaptch).offset(10);
        make.centerY.equalTo(cellBackGroundViewPwd);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [_txfPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconPwd.mas_right).offset(10);
        make.centerY.equalTo(cellBackGroundViewPwd);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
    }];
    _txfPwd.placeholder = @"设置最少6位密码";
    
    UIButton *btnVerify = [UIButton buttonWithType:UIButtonTypeCustom];
    btnVerify.layer.cornerRadius = 6;
    [btnVerify setTitle:@"确   定" forState:UIControlStateNormal];
    [btnVerify.titleLabel setFont:DEFAULT_FONT(15)];
    [btnVerify.titleLabel setTextColor:[UIColor whiteColor]];
    [btnVerify setBackgroundColor:ZN_FONNT_04_ORANGE];
    [btnVerify addTarget:self action:@selector(verifyMobile) forControlEvents:UIControlEventTouchUpInside];
    [_mobileViewContoller addSubview:btnVerify];
    [btnVerify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cellBackGroundViewPwd.mas_bottom).offset(15);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(self.view.frame.size.width-40));
        make.height.equalTo(@40);
    }];
}

-(void)buildEmailUI{
    
    [self.view setBackgroundColor:ZN_BACKGROUND_COLOR];
    _emailViewController = [UIView new];
    [self.view addSubview:_emailViewController];
    [_emailViewController mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom).offset(5);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    UIView *cellBackGroundView = [[UIView alloc]initWithFrame:CGRectZero];
    cellBackGroundView.layer.borderColor = ZN_BORDER_LINE_COLOR.CGColor;
    cellBackGroundView.layer.borderWidth = 0.5f;
    [cellBackGroundView setBackgroundColor:[UIColor whiteColor]];
    
    iconEmail = [[UIImageView alloc]initWithFrame:CGRectZero];
    [iconEmail setImage:[UIImage imageNamed:@"email_icon"]];
    
    _txfMobile = [[UITextField alloc]initWithFrame:CGRectZero];
    [_txfMobile setDelegate:self];
    [_txfMobile setTextColor:ZN_FONNT_01_BLACK];
    [_txfMobile setFont:DEFAULT_FONT(14)];
    [_txfMobile setPlaceholder:@"请输入您的邮箱账号"];
    
    [_txfMobile setText:@""];
    
    [cellBackGroundView addSubview:iconEmail];
    [cellBackGroundView addSubview:_txfMobile];
    [_emailViewController addSubview:cellBackGroundView];
    
    [cellBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom).offset(10);
        make.height.equalTo(@44);
        make.width.equalTo(self.view);
    }];
    [iconEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cellBackGroundView).offset(10);
        make.centerY.equalTo(cellBackGroundView);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [_txfMobile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconEmail.mas_right).offset(10);
        make.centerY.equalTo(cellBackGroundView);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
    }];
    
    // 验证码
    UIView *cellBackGroundViewCaptch = [[UIView alloc]initWithFrame:CGRectZero];
    cellBackGroundViewCaptch.layer.borderColor = ZN_BORDER_LINE_COLOR.CGColor;
    cellBackGroundViewCaptch.layer.borderWidth = 0.5f;
    [cellBackGroundViewCaptch setBackgroundColor:[UIColor whiteColor]];
    
    iconCaptch = [[UIImageView alloc]initWithFrame:CGRectZero];
    [iconCaptch setImage:[UIImage imageNamed:@"code_icon"]];
    
    _txfCaptch = [[UITextField alloc]initWithFrame:CGRectZero];
    [_txfCaptch setDelegate:self];
    [_txfCaptch setTextColor:ZN_FONNT_01_BLACK];
    [_txfCaptch setFont:DEFAULT_FONT(14)];
    [cellBackGroundViewCaptch addSubview:_txfCaptch];
    [cellBackGroundViewCaptch addSubview:iconCaptch];
    [_emailViewController addSubview:cellBackGroundViewCaptch];
    [cellBackGroundViewCaptch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cellBackGroundView.mas_bottom).offset(-0.5f);
        make.height.equalTo(@44);
        make.width.equalTo(self.view);
    }];
    [iconCaptch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cellBackGroundViewCaptch).offset(10);
        make.centerY.equalTo(cellBackGroundViewCaptch);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [_txfCaptch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconCaptch.mas_right).offset(10);
        make.centerY.equalTo(cellBackGroundViewCaptch);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
    }];
    _txfCaptch.placeholder = @"请输入邮箱中的验证码";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = 3;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(getCaptchAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    button.titleLabel.font = DEFAULT_FONT(14);
    button.layer.cornerRadius = 4;
    [button setBackgroundColor:ZN_FONNT_04_ORANGE];
    [cellBackGroundViewCaptch addSubview:button];
//    self.getCaptchButton  = button;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cellBackGroundViewCaptch).offset(-10);
        make.width.equalTo(@90);
        make.height.equalTo(@30);
        make.centerY.equalTo(cellBackGroundViewCaptch);
    }];
    
    // 密码
    UIView *cellBackGroundViewPwd = [[UIView alloc]initWithFrame:CGRectZero];
    cellBackGroundViewPwd.layer.borderColor = ZN_BORDER_LINE_COLOR.CGColor;
    cellBackGroundViewPwd.layer.borderWidth = 0.5f;
    [cellBackGroundViewPwd setBackgroundColor:[UIColor whiteColor]];
    iconPwd = [[UIImageView alloc]initWithFrame:CGRectZero];
    [iconPwd setImage:[UIImage imageNamed:@"pw_icon"]];
    
    _txfPwd = [[UITextField alloc]initWithFrame:CGRectZero];
    [_txfPwd setDelegate:self];
    [_txfPwd setTextColor:ZN_FONNT_01_BLACK];
    [_txfPwd setFont:DEFAULT_FONT(14)];
    [cellBackGroundViewPwd addSubview:_txfPwd];
    [cellBackGroundViewPwd addSubview:iconPwd];
    [_emailViewController addSubview:cellBackGroundViewPwd];
    [cellBackGroundViewPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cellBackGroundViewCaptch.mas_bottom).offset(-0.5f);
        make.height.equalTo(@44);
        make.width.equalTo(self.view);
    }];
    [iconPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cellBackGroundViewCaptch).offset(10);
        make.centerY.equalTo(cellBackGroundViewPwd);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [_txfPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconPwd.mas_right).offset(10);
        make.centerY.equalTo(cellBackGroundViewPwd);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
    }];
    _txfPwd.placeholder = @"设置最少6位密码";
    
    UIButton *btnVerify = [UIButton buttonWithType:UIButtonTypeCustom];
    btnVerify.layer.cornerRadius = 6;
    [btnVerify setTitle:@"确   定" forState:UIControlStateNormal];
    [btnVerify.titleLabel setFont:DEFAULT_FONT(15)];
    [btnVerify.titleLabel setTextColor:[UIColor whiteColor]];
    [btnVerify setBackgroundColor:ZN_FONNT_04_ORANGE];
    [btnVerify addTarget:self action:@selector(verifyMobile) forControlEvents:UIControlEventTouchUpInside];
    [_emailViewController addSubview:btnVerify];
    [btnVerify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cellBackGroundViewPwd.mas_bottom).offset(15);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(self.view.frame.size.width-40));
        make.height.equalTo(@40);
    }];
    
}

-(void)backTime:(NSTimer *)timer
{
    NSString *countString = [NSString stringWithFormat:@"%ld秒",(long)_count];
    [self.getCaptchButton setTitle:countString forState:UIControlStateNormal];
    _count--;
    if (!_count) {
        _count = 60;
        [_timer setFireDate:[NSDate distantFuture]];//定时器关闭
        self.getCaptchButton.enabled = YES;
        [self.getCaptchButton setBackgroundColor:ZN_FONNT_04_ORANGE];
        [self.getCaptchButton setTitle:@"重新发送" forState:UIControlStateNormal];
    }
}
-(void)getCapthcActionMobile:(UIButton *)btn{
    [self.view endEditing:YES];
    self.getCaptchButton.enabled = NO;
    self.getCaptchButton.layer.borderColor = [UIColor grayColor].CGColor;
    [self.getCaptchButton setBackgroundColor:[UIColor grayColor]];
    [_timer setFireDate:[NSDate distantPast]];//定时器开启
    [self showHudInView:self.view hint:loadingHintStr];
}

-(void)getCaptchAction:(UIButton *)btn {
    if (_txfMobile.text.length>0){
        [self showHudInView:self.view hint:@"正在发送验证码..."];
        NSDictionary *requestDic = [[NSDictionary alloc]initWithObjectsAndKeys:_txfMobile.text,@"email",nil];
        [ZNApi invokePost:ZN_VERIFY_EMAIL_API parameters:requestDic completion:^(id resultObj,NSString *msg,ZNRespModel *respModel) {
            [self hideHud];
            if(respModel.success.intValue){
                [JGProgressHUD showSuccessStr:@"验证码已发送至邮箱！"];
            }else{
                [JGProgressHUD showErrorStr:@"发送出现问题，请重新发送！"];
            }
        }];
    }else{
        [JGProgressHUD showErrorStr:@"请输入邮箱地址！"];
    }
}
-(void)verifyMobile{
    if(!(_txfMobile.text.length > 0)){
        ViewShaker *shakerLab = [[ViewShaker alloc]initWithView:_txfMobile];
        [shakerLab shake];
        [self playSound];
        return;
    }
    if(!(_txfCaptch.text.length >0)){
        ViewShaker *shakerLab = [[ViewShaker alloc]initWithViewsArray:@[_txfCaptch,self.getCaptchButton]];
        [shakerLab shake];
        [self playSound];
        return ;
    }
    if(!(_txfPwd.text.length >0)){
        ViewShaker *shakerLab = [[ViewShaker alloc]initWithViewsArray:@[_txfPwd]];
        [shakerLab shake];
        [self playSound];
        return ;
    }
    [self.view endEditing:YES];
    
    if(!self.isRemakePwd){
    [self showHudInView:self.view hint:@"正在注册..."];
    // 注册接口
    NSDictionary *requestDic = [[NSDictionary alloc]initWithObjectsAndKeys:_txfMobile.text,@"email",
                                [NSString stringWithFormat:@"%@",[ZNAppUtil toMd5:_txfPwd.text]],@"password",
                                [NSString stringWithFormat:@"%@",_txfCaptch.text],@"code",nil];
    [ZNApi invokePost:ZN_REGISTER_EMIL_API parameters:requestDic completion:^(id resultObj,NSString *msg,ZNRespModel *respModel) {
        [self hideHud];
        if(respModel.success.intValue){
            [JGProgressHUD showSuccessStr:@"注册成功！"];
        }else{
            [JGProgressHUD showErrorStr:@"注册出现问题，请稍后再试！"];
        }
        RegisterSuccessViewController *regSuccessVC = [RegisterSuccessViewController new];
        [self.navigationController pushViewController:regSuccessVC animated:YES];
    }];
    
    }else{
        // 找回
        NSDictionary *requestDic = [[NSDictionary alloc]initWithObjectsAndKeys:_txfMobile.text,@"email",
                                    [NSString stringWithFormat:@"%@",[ZNAppUtil toMd5:_txfPwd.text]],@"password",
                                    [NSString stringWithFormat:@"%@",_txfCaptch.text],@"code",nil];
        [ZNApi invokePost:ZN_REGISTER_EMIL_API parameters:requestDic completion:^(id resultObj,NSString *msg,ZNRespModel *respModel) {
            [self hideHud];
            if(respModel.success.intValue){
                [JGProgressHUD showSuccessStr:@"找回密码成功！"];
            }else{
                [JGProgressHUD showErrorStr:@"找回密码出现问题，请稍后再试！"];
            }
            RegisterSuccessViewController *regSuccessVC = [RegisterSuccessViewController new];
            [self.navigationController pushViewController:regSuccessVC animated:YES];
        }];
    
    }
    
}
-(void) playSound {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shake_sound" ofType:@"caf"];
    if (path) {
        //注册声音到系统
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_id);
        AudioServicesPlaySystemSound(shake_sound_id);
    }
    AudioServicesPlaySystemSound(shake_sound_id);   //播放注册的声音，（此句代码，可以在本类中的任意位置调用，不限于本方法中）
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   //让手机震动
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
//    if (textField.tag == 1) {
//        self.mobileNumStr = textField.text;
//    } else if(textField.tag == 2){
//        self.captchCodeStr = textField.text;
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
