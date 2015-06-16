//
//  FeedBackViewController.m
//  问题反馈
//
//  Created by aokuny on 15/5/30.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController (){
    // 反馈内容
    UITextView *gTextView;
    // 反馈提醒
    UILabel *gLabelPlaceHolder;
}

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"意见反馈"];
    [self setBackBarButton];
    [self setRightBarButtonItemTitle:@"发送" target:self action:@selector(sendFeedBack)];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.view setBackgroundColor:ZN_BACKGROUND_COLOR];
    gTextView = [[UITextView alloc]initWithFrame:CGRectMake(0,15,self.view.frame.size.width,160)];
    [gTextView setTextColor:[UIColor grayColor]];
    [gTextView becomeFirstResponder];
    [gTextView setFont:DEFAULT_FONT(13)];
    [gTextView setDelegate:self];
    
    gLabelPlaceHolder = [[UILabel alloc]initWithFrame:CGRectMake(gTextView.frame.origin.x+8,gTextView.frame.origin.y+2,
                                                                 gTextView.frame.size.width-2,30)];
    gLabelPlaceHolder.text  = @"尽可能详细描述问题原因、现象等信息，需大于15个汉字！";
    gLabelPlaceHolder.numberOfLines = 0;
    [gLabelPlaceHolder setFont:DEFAULT_FONT(11)];
    gLabelPlaceHolder.enabled = NO;
    
    [self.view addSubview:gTextView];
    [self.view addSubview:gLabelPlaceHolder];

}
-(void) sendFeedBack{
    if(gTextView.text.length<=0){
        [JGProgressHUD showHintStr:@"反馈内容不能为空！"];
        return ;
    }
    if(gTextView.text.length<=15){
        [JGProgressHUD showHintStr:@"反馈内容需大于15个汉字！"];
        return ;
    }
    // send to server
    NSDictionary *requestDic= @{@"conInfo":gTextView.text,
                                @"mobileType":@"ios"
                                };
    [self showHudInView:self.view hint:@"正在发送。。。"];
    __weak typeof(self) weakSelf = self;
    [ZNApi invokePost:ZN_ADDFEEDBACK_API parameters:requestDic completion:^(id resultObj,NSString *msg,ZNRespModel *respModel){
        if (respModel.success.intValue>0) {
            [JGProgressHUD showSuccessStr:@"问题反馈成功！"];
            [gTextView setText:@""];
            gLabelPlaceHolder.hidden = NO;
        }else{
            [JGProgressHUD showHintStr:respModel.msg];
        }
        [weakSelf hideHud];
    }];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@""]) {
        gLabelPlaceHolder.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        gLabelPlaceHolder.hidden = NO;
    }

    if (range.location >= 200){
        [JGProgressHUD showHintStr:@"超过最大字数不能输入了"];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
