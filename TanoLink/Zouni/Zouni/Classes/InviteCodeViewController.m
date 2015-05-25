//
//  InviteCodeViewController.m
//  邀请码绑定
//
//  Created by aokuny on 15/5/24.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "InviteCodeViewController.h"
#import "ZNAppUtil.h"
#import "ViewShaker.h"
#import <AudioToolbox/AudioToolbox.h>

static SystemSoundID shake_sound_id = 0;
@interface InviteCodeViewController (){
    UILabel *_labCodeDesc;
    UITextField *_txfCode;
}
@end

@implementation InviteCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"我的邀请码"];
    [self setBackBarButton];
    [self setRightBarButtonItemTitle:@"绑定" target:self action:@selector(bindInviteCode)];
    [self.view setBackgroundColor:ZN_BACKGROUND_COLOR];
    UIView *cellBackGroundView = [[UIView alloc]initWithFrame:CGRectZero];
    cellBackGroundView.layer.borderColor = ZN_BORDER_LINE_COLOR.CGColor;
    cellBackGroundView.layer.borderWidth = 0.5f;
    [cellBackGroundView setBackgroundColor:[UIColor whiteColor]];
    _labCodeDesc = [[UILabel alloc]initWithFrame:CGRectZero];
    [_labCodeDesc setFont:DEFAULT_FONT(14)];
    [_labCodeDesc setTextColor:ZN_FONNT_02_GRAY];
    [_labCodeDesc setText:@"邀请码"];
    _txfCode = [[UITextField alloc]initWithFrame:CGRectZero];
    [_txfCode setDelegate:self];
    [_txfCode setTextColor:ZN_FONNT_01_BLACK];
    [_txfCode setFont:DEFAULT_FONT(14)];
    [cellBackGroundView addSubview:_labCodeDesc];
    [cellBackGroundView addSubview:_txfCode];
    [self.view addSubview:cellBackGroundView];
    [cellBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(18);
        make.height.equalTo(@44);
        make.width.equalTo(self.view);
    }];
    [_labCodeDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cellBackGroundView).offset(15);
        make.centerY.equalTo(cellBackGroundView);
        make.width.equalTo(@60);
    }];
    [_txfCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_labCodeDesc.mas_right);
        make.centerY.equalTo(cellBackGroundView);
        make.width.equalTo(@150);
        make.height.equalTo(@20);
    }];
    [_txfCode becomeFirstResponder];
    _txfCode.keyboardType = UIKeyboardTypeNumberPad;
//      testcolor
//    [labCodeDesc setBackgroundColor:[UIColor greenColor]];
//    [txf setBackgroundColor:[UIColor orangeColor]];
    
}
#pragma mark 绑定邀请码请求
-(void) bindInviteCode{
    if(_txfCode.text.length > 0){
        [self showHudInView:self.view hint:@"正在绑定..."];
    }else{
        ViewShaker *shakerLab = [[ViewShaker alloc]initWithView:_labCodeDesc];
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
    // Dispose of any resources that can be recreated.
}

@end
