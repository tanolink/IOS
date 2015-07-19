//
//  RegisterSuccessViewController.m
//  注册成功页面
//
//  Created by aokuny on 15/6/4.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "RegisterSuccessViewController.h"
#import "CityListViewController.h"
#import "ViewShaker.h"
#import <AudioToolbox/AudioToolbox.h>

static SystemSoundID shake_sound_id = 0;
@interface RegisterSuccessViewController (){
    UIImageView *_imageView;
    UILabel *_labRegSuccess;
    UILabel *_labJumpOverDesc;
    UITextField *_txfCode;
    UIButton *_btnBindCode;
}

@end

@implementation RegisterSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    [self setTitle:@"注册成功"];
    [self setRightBarButtonItemTitle:@"跳过" target:self action:@selector(jumpOver)];
    [self.view setBackgroundColor:ZN_BACKGROUND_COLOR];
    [self buildUI];
    [self layoutUI];
}
-(void) buildUI{
    _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [_imageView setImage:[UIImage imageNamed:@"register_success"]];
    [self.view addSubview:_imageView];

    _labRegSuccess = [UILabel new];
    [_labRegSuccess setText:@"恭喜您！注册成功。"];
    [_labRegSuccess setFont:DEFAULT_FONT(18)];
    [_labRegSuccess setTextColor:ZN_FONNT_01_BLACK];
    [_labRegSuccess setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:_labRegSuccess];
    
    _labJumpOverDesc = [UILabel new];
    [_labJumpOverDesc setText:@"请输入您的旅行社邀请码，如果没有请跳过。"];
    [_labJumpOverDesc setFont:DEFAULT_BOLD_FONT(11)];
    [_labJumpOverDesc setTextColor:ZN_FONNT_02_GRAY];
    [_labJumpOverDesc setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:_labJumpOverDesc];
    
    _txfCode = [UITextField new];
    [_txfCode setDelegate:self];
    [_txfCode setPlaceholder:@"请输入旅行社邀请码"];
    [_txfCode setBackgroundColor:[UIColor whiteColor]];
    _txfCode.keyboardType = UIKeyboardTypeNumberPad;
    [_txfCode becomeFirstResponder];
    [self.view addSubview:_txfCode];
    
    _btnBindCode = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnBindCode.layer.cornerRadius = 6;
    [_btnBindCode setTitle:@"确   定" forState:UIControlStateNormal];
    [_btnBindCode.titleLabel setFont:DEFAULT_FONT(15)];
    [_btnBindCode.titleLabel setTextColor:[UIColor whiteColor]];
    [_btnBindCode setBackgroundColor:ZN_FONNT_04_ORANGE];
    [_btnBindCode addTarget:self action:@selector(bindInviteCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnBindCode];
}
-(void)layoutUI{
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(20);
        make.height.equalTo(@50);
        make.width.equalTo(@50);
    }];
    [_labRegSuccess mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView.mas_top).offset(5);
        make.left.equalTo(_imageView.mas_right).offset(20);
        make.right.equalTo(self.view);
        make.height.equalTo(@20);
    }];
    [_labJumpOverDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_labRegSuccess.mas_bottom).offset(6);
        make.left.equalTo(_labRegSuccess);
        make.right.equalTo(self.view);
        make.height.equalTo(@13);
    }];
    [_txfCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView.mas_bottom).offset(20);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    [_btnBindCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_txfCode.mas_bottom).offset(15);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(self.view.frame.size.width-40));
        make.height.equalTo(@40);
    }];
    
    CGRect frame = [_txfCode frame];
    frame.size.width = 15.0f;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    _txfCode.leftViewMode = UITextFieldViewModeAlways;
    _txfCode.leftView = leftview;
}
#pragma mark 跳过
-(void)jumpOver{
    CityListViewController *cityList = [CityListViewController new];
    cityList.isNeedBack = YES;
    [self.navigationController pushViewController:cityList animated:YES];
}

#pragma mark 绑定邀请码请求
-(void) bindInviteCode{
    if(_txfCode.text.length > 0){
        [self showHudInView:self.view hint:@"正在绑定..."];
        NSDictionary *requestDic= @{@"code":_txfCode.text};
        __weak typeof(self) weakSelf = self;
        [ZNApi invokePost:ZN_BINDCODE_API parameters:requestDic completion:^(id resultObj,NSString *msg,ZNRespModel *respModel){
            if (respModel.success.intValue>0) {
                [JGProgressHUD showSuccessStr:@"绑定成功！"];
                // 更改本地
                [ZNClientInfo sharedClinetInfo].memberInfo.code = _txfCode.text;
                [[ZNClientInfo sharedClinetInfo] saveMemberInfo];
                
                [self performSelector:@selector(jumpOver) withObject:nil afterDelay:1];
            }else{
                [JGProgressHUD showHintStr:msg];
            }
            [weakSelf hideHud];
        }];
    }else{
        ViewShaker *shakerLab = [[ViewShaker alloc]initWithView:_txfCode];
        [shakerLab shake];
        [self playSound];
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

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
