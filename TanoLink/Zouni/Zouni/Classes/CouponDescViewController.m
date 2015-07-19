//
//  CouponDescViewController.m
//  优惠券规则说明
//
//  Created by aokuny on 15/5/24.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "CouponDescViewController.h"
#import "ZNAppUtil.h"

@interface CouponDescViewController ()

@end

@implementation CouponDescViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"如何使用优惠券"];
    [self setBackBarButton];
    [self.view setBackgroundColor:ZN_BACKGROUND_COLOR];
    UILabel *labDesc = [[UILabel alloc]initWithFrame:CGRectZero];
    [labDesc setFont:DEFAULT_FONT(12)];
    [labDesc setTextColor:ZN_FONNT_01_BLACK];
    [labDesc setText:@"详细规则："];
    UITextView *labContent = [[UITextView alloc]initWithFrame:CGRectZero];
    [labContent setFont:DEFAULT_FONT(12)];
    [labContent setTextColor:ZN_FONNT_02_GRAY];
    [labContent setTextAlignment:NSTextAlignmentLeft];
    [labContent setBackgroundColor:ZN_BACKGROUND_COLOR];
    [labContent setEditable:NO];
    
    [self.view addSubview:labDesc];
    [self.view addSubview:labContent];
    
    [labDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(15);
        make.left.equalTo(self.view).offset(15);
        make.height.equalTo(@17);
        make.width.equalTo(@100);
    }];
    
    [labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labDesc.mas_bottom).offset(15);
        make.left.equalTo(labDesc);
        make.right.equalTo(self.view).offset(-15);
//        make.height.equalTo(@15);
        // ==================================这里要改成自适应高度
        make.bottom.equalTo(self.view);
    }];
    
    [labContent setText:self.howToUseCoupon];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
