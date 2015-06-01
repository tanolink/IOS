//
//  BindMobileViewController.m
//  绑定手机
//
//  Created by aokuny on 15/5/31.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "BindMobileViewController.h"
#import "ZNAppUtil.h"
#import "ViewShaker.h"
#import <AudioToolbox/AudioToolbox.h>
static SystemSoundID shake_sound_id = 0;

@interface BindMobileViewController ()
@property (nonatomic, strong) NSString *mobileNumStr;
@property (nonatomic, strong) NSString *captchCodeStr;

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIButton *getCaptchButton;

@end
@implementation BindMobileViewController{
    UITextField *_txfMobile;
    UITextField *_txfCaptch;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _count=  60;
    [self setTitle:@"手机绑定"];
    [self setBackBarButton];
    self.mobileNumStr = @"";
    [self.view setBackgroundColor:ZN_BACKGROUND_COLOR];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(backTime:) userInfo:nil repeats:YES];
    [_timer setFireDate:[NSDate distantFuture]];//定时器关闭
    
    [self.view setBackgroundColor:ZN_BACKGROUND_COLOR];
    
    UIView *cellBackGroundView = [[UIView alloc]initWithFrame:CGRectZero];
    cellBackGroundView.layer.borderColor = ZN_BORDER_LINE_COLOR.CGColor;
    cellBackGroundView.layer.borderWidth = 0.5f;
    [cellBackGroundView setBackgroundColor:[UIColor whiteColor]];
    
    _txfMobile = [[UITextField alloc]initWithFrame:CGRectZero];
    [_txfMobile setDelegate:self];
    [_txfMobile setTextColor:ZN_FONNT_01_BLACK];
    [_txfMobile setFont:DEFAULT_FONT(14)];
    [_txfMobile setPlaceholder:@"填写11位手机号码"];
    _txfMobile.text = self.mobileNumStr;
    NSMutableString *str = [self.oldMobileStr mutableCopy];
    [str replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    _txfMobile.text = str;
    [cellBackGroundView addSubview:_txfMobile];
    [self.view addSubview:cellBackGroundView];
    
    [cellBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(18);
        make.height.equalTo(@44);
        make.width.equalTo(self.view);
    }];
    [_txfMobile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cellBackGroundView).offset(10);
        make.centerY.equalTo(cellBackGroundView);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
    }];
    
    // 验证码
    UIView *cellBackGroundViewCaptch = [[UIView alloc]initWithFrame:CGRectZero];
    cellBackGroundViewCaptch.layer.borderColor = ZN_BORDER_LINE_COLOR.CGColor;
    cellBackGroundViewCaptch.layer.borderWidth = 0.5f;
    [cellBackGroundViewCaptch setBackgroundColor:[UIColor whiteColor]];
    _txfCaptch = [[UITextField alloc]initWithFrame:CGRectZero];
    [_txfCaptch setDelegate:self];
    [_txfCaptch setTextColor:ZN_FONNT_01_BLACK];
    [_txfCaptch setFont:DEFAULT_FONT(14)];
    [cellBackGroundViewCaptch addSubview:_txfCaptch];
    [self.view addSubview:cellBackGroundViewCaptch];
    [cellBackGroundViewCaptch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cellBackGroundView.mas_bottom).offset(-0.5f);
        make.height.equalTo(@44);
        make.width.equalTo(self.view);
    }];
    [_txfCaptch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cellBackGroundViewCaptch).offset(10);
        make.centerY.equalTo(cellBackGroundViewCaptch);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
    }];
    _txfCaptch.placeholder = @"请输入手机短信中的验证码";
    _txfCaptch.text = self.captchCodeStr;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = 2;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(getCaptchAction:) forControlEvents:UIControlEventTouchUpInside];
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
    
    UIButton *btnVerify = [UIButton buttonWithType:UIButtonTypeCustom];
    btnVerify.layer.cornerRadius = 6;
    [btnVerify setTitle:@"验   证" forState:UIControlStateNormal];
    [btnVerify.titleLabel setFont:DEFAULT_FONT(15)];
    [btnVerify.titleLabel setTextColor:[UIColor whiteColor]];
    [btnVerify setBackgroundColor:ZN_FONNT_04_ORANGE];
    [btnVerify addTarget:self action:@selector(verifyMobile) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnVerify];
    [btnVerify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cellBackGroundViewCaptch.mas_bottom).offset(15);
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

-(void)getCaptchAction:(UIButton *)btn {
    [self.view endEditing:YES];
    NSString *mobileNum = self.oldMobileStr;
    self.getCaptchButton.enabled = NO;
    self.getCaptchButton.layer.borderColor = [UIColor grayColor].CGColor;
    [self.getCaptchButton setBackgroundColor:[UIColor grayColor]];
    [_timer setFireDate:[NSDate distantPast]];//定时器开启
    [self showHudInView:self.view hint:loadingHintStr];
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
    [self.view endEditing:YES];
    [self showHudInView:self.view hint:@"正在验证..."];
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
    if (textField.tag == 1) {
        self.mobileNumStr = textField.text;
    } else if(textField.tag == 2){
        self.captchCodeStr = textField.text;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
