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
    [self setTitle:@"关于"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self buildUI];
}
-(void) buildUI{
    UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    float headerSize = 80;
//    headerBtn.layer.cornerRadius = headerSize / 2.f;
    headerBtn.layer.cornerRadius = 13;
    headerBtn.layer.masksToBounds = YES;
    [headerBtn setImage:[UIImage imageNamed:@"Icon"] forState:UIControlStateNormal];
    [headerBtn setUserInteractionEnabled:NO];
    
    [self.view addSubview:headerBtn];
    
    UITextView *textView = [UITextView new];
    [textView setEditable:NO];
    [textView setTextColor:ZN_FONNT_02_GRAY];
    [textView setText:@"走你app免费提供全日本的美食，药妆，百货服饰等多功能服务。定期发表日本人气商品，提供购买平台。让您有一种与日本零距离的感觉，第一时间得到最新情报。今后去日本您不用任何担心，直接走你。"];
    [textView setFont:DEFAULT_BOLD_FONT(13)];
    [self.view addSubview:textView];
    
    [headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(30);
        make.width.equalTo(@(headerSize));
        make.height.equalTo(@(headerSize));
        make.centerX.equalTo(self.view);
    }];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerBtn.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.width.equalTo(self.view).offset(-20);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
