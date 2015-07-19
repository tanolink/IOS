//
//  ChangeNickNameViewController.m
//  修改昵称
//  Created by aokuny on 15/5/31.
//  Copyright (c) 2015年 TanoLink. All rights reserved.

#import "ChangeNickNameViewController.h"
#import "ZNAppUtil.h"
#import "ViewShaker.h"
#import <AudioToolbox/AudioToolbox.h>
static SystemSoundID shake_sound_id = 0;
@interface ChangeNickNameViewController (){
    UILabel *_labNickNameDesc;
    UITextField *_txfNickName;
}

@end

@implementation ChangeNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"修改昵称"];
    [self setBackBarButton];
    [self setRightBarButtonItemTitle:@"提交" target:self action:@selector(changeNickName)];
    [self.view setBackgroundColor:ZN_BACKGROUND_COLOR];
    UIView *cellBackGroundView = [[UIView alloc]initWithFrame:CGRectZero];
    cellBackGroundView.layer.borderColor = ZN_BORDER_LINE_COLOR.CGColor;
    cellBackGroundView.layer.borderWidth = 0.5f;
    [cellBackGroundView setBackgroundColor:[UIColor whiteColor]];
    _labNickNameDesc = [[UILabel alloc]initWithFrame:CGRectZero];
    [_labNickNameDesc setFont:DEFAULT_FONT(14)];
    [_labNickNameDesc setTextColor:ZN_FONNT_02_GRAY];
    [_labNickNameDesc setText:@"昵称"];
    _txfNickName = [[UITextField alloc]initWithFrame:CGRectZero];
    [_txfNickName setDelegate:self];
    [_txfNickName setTextColor:ZN_FONNT_01_BLACK];
    [_txfNickName setFont:DEFAULT_FONT(14)];
    [_txfNickName setPlaceholder:@"请输入昵称"];
    [cellBackGroundView addSubview:_labNickNameDesc];
    [cellBackGroundView addSubview:_txfNickName];
    [self.view addSubview:cellBackGroundView];
    [cellBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(18);
        make.height.equalTo(@44);
        make.width.equalTo(self.view);
    }];
    [_labNickNameDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cellBackGroundView).offset(15);
        make.centerY.equalTo(cellBackGroundView);
        make.width.equalTo(@60);
    }];
    [_txfNickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_labNickNameDesc.mas_right);
        make.centerY.equalTo(cellBackGroundView);
        make.width.equalTo(@150);
        make.height.equalTo(@20);
    }];
    [_txfNickName becomeFirstResponder];
    
    [self initData];
}
-(void) initData{
    if([ZNClientInfo sharedClinetInfo].memberInfo.nickname.length>0){
        _txfNickName.text = [ZNClientInfo sharedClinetInfo].memberInfo.nickname;
    }
}
#pragma mark 绑定邀请码请求
-(void) changeNickName {
    if(_txfNickName.text.length > 0){
        [self showHudInView:self.view hint:@"正在修改昵称..."];
        NSDictionary *requestDic= @{@"nickName":_txfNickName.text,@"upor":@""};
        __weak typeof(self) weakSelf = self;
        [ZNApi invokePost:ZN_CHANGEUSER_API parameters:requestDic completion:^(id resultObj,NSString *msg,ZNRespModel *respModel){
            if (respModel.success.intValue>0) {
                [JGProgressHUD showSuccessStr:@"昵称修改成功！"];
                // 更改本地昵称
                [ZNClientInfo sharedClinetInfo].memberInfo.nickname = _txfNickName.text;
                [[ZNClientInfo sharedClinetInfo] saveMemberInfo];
            }else{
                [JGProgressHUD showHintStr:msg];
            }
            [weakSelf hideHud];
        }];
    }else{
        ViewShaker *shakerLab = [[ViewShaker alloc]initWithView:_labNickNameDesc];
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
