//
//  AboutUsViewController.m
//  关于我们
//
//  Created by aokuny on 15/5/30.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    [self setTitle:@"关于我们"];
    [self.view setBackgroundColor:ZN_BACKGROUND_COLOR];
    
    UILabel *labTitle = [UILabel new];
    [labTitle setFont:DEFAULT_BOLD_FONT(15)];
    [labTitle setTextColor:ZN_FONNT_01_BLACK];
    [labTitle setText:@"关于走你TanoLink"];
    [labTitle setTextAlignment:NSTextAlignmentLeft];
    [labTitle setBackgroundColor:[UIColor clearColor]];
    [labTitle setNumberOfLines:0];
    [self.view addSubview:labTitle];
    
    UITextView *textView = [UITextView new];
    [textView setEditable:NO];
    [textView setBackgroundColor:ZN_BACKGROUND_COLOR];
    [textView setTextColor:ZN_FONNT_02_GRAY];
    [textView setText:@"本公司是在中国国家法务局正式登录的独立法人有限公司。我们开发的“走你”APP是中国国内，第一个专门面向海外游的中国游客，派发国外直接使用的优惠券，打折信息的手机软件。目前受到旅游业界的关注，得到国内各大旅行社的提携."];
    [textView setFont:DEFAULT_FONT(13)];
    [self.view addSubview:textView];
    
    [labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.height.equalTo(@25);
        make.width.equalTo(self.view).offset(-20);
    }];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labTitle.mas_bottom);
        make.width.equalTo(self.view).offset(-20);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
