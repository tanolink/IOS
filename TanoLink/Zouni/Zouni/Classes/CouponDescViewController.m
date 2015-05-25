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
    [labDesc setFont:DEFAULT_FONT(15)];
    [labDesc setTextColor:ZN_FONNT_01_BLACK];
    [labDesc setText:@"详细规则："];
    UILabel *labContent = [[UILabel alloc]initWithFrame:CGRectZero];
    [labDesc setFont:DEFAULT_FONT(12)];
    [labDesc setTextColor:ZN_FONNT_02_GRAY];
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
        make.bottom.equalTo(self.view);
    }];
    
    [labContent setText:@"优惠活动。。。"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
