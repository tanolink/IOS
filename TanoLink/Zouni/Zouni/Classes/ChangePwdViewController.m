//
//  ChangePwdViewController.m
//  修改密码
//
//  Created by aokuny on 15/5/31.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "ChangePwdViewController.h"
#import "ZNAppUtil.h"
#import "ViewShaker.h"
#import <AudioToolbox/AudioToolbox.h>
static SystemSoundID shake_sound_id = 0;

@interface ChangePwdViewController (){
    UITextField *_txfOldPwd;
    UITextField *_txfNewPwd;
    UITextField *_txfVerifyNewPwd;
}

@end

@implementation ChangePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"修改密码"];
    [self setBackBarButton];
//    [self setRightBarButtonItemTitle:@"提交" target:self action:@selector(changePWD)];
    [self.view setBackgroundColor:ZN_BACKGROUND_COLOR];
    
    UIView *cellBackGroundView = [[UIView alloc]initWithFrame:CGRectZero];
    cellBackGroundView.layer.borderColor = ZN_BORDER_LINE_COLOR.CGColor;
    cellBackGroundView.layer.borderWidth = 0.5f;
    [cellBackGroundView setBackgroundColor:[UIColor whiteColor]];

    _txfOldPwd = [[UITextField alloc]initWithFrame:CGRectZero];
    [_txfOldPwd setDelegate:self];
    [_txfOldPwd setTextColor:ZN_FONNT_01_BLACK];
    [_txfOldPwd setFont:DEFAULT_FONT(14)];
    [_txfOldPwd setPlaceholder:@"请输入当前密码"];
    _txfOldPwd.secureTextEntry = YES;
    [cellBackGroundView addSubview:_txfOldPwd];
    [self.view addSubview:cellBackGroundView];
    [cellBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(18);
        make.height.equalTo(@44);
        make.width.equalTo(self.view);
    }];
    [_txfOldPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cellBackGroundView).offset(10);
        make.centerY.equalTo(cellBackGroundView);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
    }];
    
    // 新密码
    UIView *cellBackGroundViewNewPwd = [[UIView alloc]initWithFrame:CGRectZero];
    cellBackGroundViewNewPwd.layer.borderColor = ZN_BORDER_LINE_COLOR.CGColor;
    cellBackGroundViewNewPwd.layer.borderWidth = 0.5f;
    [cellBackGroundViewNewPwd setBackgroundColor:[UIColor whiteColor]];
    _txfNewPwd = [[UITextField alloc]initWithFrame:CGRectZero];
    [_txfNewPwd setDelegate:self];
    [_txfNewPwd setTextColor:ZN_FONNT_01_BLACK];
    [_txfNewPwd setFont:DEFAULT_FONT(14)];
    [_txfNewPwd setPlaceholder:@"请输入新密码"];
    _txfNewPwd.secureTextEntry = YES;
    [cellBackGroundViewNewPwd addSubview:_txfNewPwd];
    [self.view addSubview:cellBackGroundViewNewPwd];
    [cellBackGroundViewNewPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cellBackGroundView.mas_bottom).offset(-0.5f);
        make.height.equalTo(@44);
        make.width.equalTo(self.view);
    }];
    [_txfNewPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cellBackGroundViewNewPwd).offset(10);
        make.centerY.equalTo(cellBackGroundViewNewPwd);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
    }];

    // 确认新密码
    UIView *cellBackGroundViewVerifyPwd = [[UIView alloc]initWithFrame:CGRectZero];
    cellBackGroundViewVerifyPwd.layer.borderColor = ZN_BORDER_LINE_COLOR.CGColor;
    cellBackGroundViewVerifyPwd.layer.borderWidth = 0.5f;
    [cellBackGroundViewVerifyPwd setBackgroundColor:[UIColor whiteColor]];
    
    _txfVerifyNewPwd = [[UITextField alloc]initWithFrame:CGRectZero];
    [_txfVerifyNewPwd setDelegate:self];
    [_txfVerifyNewPwd setTextColor:ZN_FONNT_01_BLACK];
    [_txfVerifyNewPwd setFont:DEFAULT_FONT(14)];
    [_txfVerifyNewPwd setPlaceholder:@"确认新密码"];
    _txfVerifyNewPwd.secureTextEntry = YES;
    [cellBackGroundViewVerifyPwd addSubview:_txfVerifyNewPwd];
    [self.view addSubview:cellBackGroundViewVerifyPwd];
    [cellBackGroundViewVerifyPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cellBackGroundViewNewPwd.mas_bottom).offset(-1);
        make.height.equalTo(@44);
        make.width.equalTo(self.view);
    }];
    [_txfVerifyNewPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cellBackGroundViewVerifyPwd).offset(10);
        make.centerY.equalTo(cellBackGroundViewVerifyPwd);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
    }];
    
    UIButton *btnOneKeySearch = [UIButton buttonWithType:UIButtonTypeCustom];
    btnOneKeySearch.layer.cornerRadius = 6;
    [btnOneKeySearch setTitle:@"提   交" forState:UIControlStateNormal];
    [btnOneKeySearch.titleLabel setFont:DEFAULT_FONT(15)];
    [btnOneKeySearch.titleLabel setTextColor:[UIColor whiteColor]];
    [btnOneKeySearch setBackgroundColor:ZN_FONNT_04_ORANGE];
    [btnOneKeySearch addTarget:self action:@selector(changePWD) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnOneKeySearch];
    [btnOneKeySearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cellBackGroundViewVerifyPwd.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(self.view.frame.size.width-40));
        make.height.equalTo(@40);
    }];
}

#pragma mark 修改密码请求
-(void) changePWD {
    if(!(_txfOldPwd.text.length > 0)){
        ViewShaker *shakerLab = [[ViewShaker alloc]initWithView:_txfOldPwd];
        [shakerLab shake];
        [self playSound];
        return;
    }
    if(!(_txfNewPwd.text.length >0)){
        ViewShaker *shakerLab = [[ViewShaker alloc]initWithView:_txfNewPwd];
        [shakerLab shake];
        [self playSound];
        return ;
    }
    if(!(_txfVerifyNewPwd.text.length >0)){
        ViewShaker *shakerLab = [[ViewShaker alloc]initWithView:_txfVerifyNewPwd];
        [shakerLab shake];
        [self playSound];
        return ;
    }
    if([_txfNewPwd.text isEqual:_txfVerifyNewPwd.text]){
        [self showHudInView:self.view hint:@"正在修改密码..."];
        NSDictionary *requestDic= @{@"password":_txfOldPwd.text,
                                    @"newPassword":_txfNewPwd.text,
                                    @"confirmPwd":_txfVerifyNewPwd.text
                                    };
        __weak typeof(self) weakSelf = self;
        [ZNApi invokePost:ZN_REPWD_API parameters:requestDic completion:^(id resultObj,NSString *msg,ZNRespModel *respModel){
            if (respModel.success.intValue>0) {
                [JGProgressHUD showSuccessStr:@"密码修改成功！"];
                // 更改本地密码
                
            }else{
                [JGProgressHUD showHintStr:respModel.msg];
            }
            [weakSelf hideHud];
        }];
    }else{
        [JGProgressHUD showErrorStr:@"两次输入的新密码不一致！"];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
