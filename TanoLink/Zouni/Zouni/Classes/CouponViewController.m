//
//  CouponViewController.m
//  优惠券
//
//  Created by aokuny on 15/5/18.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "CouponViewController.h"

@interface CouponViewController (){
    // 白色背景
    UIView *_bgView;
    // 顶部黄色背景
    UIView *_topView;
    // logo 圆形
    UIButton *_btnLogoCircle;
    // logo 方形
    UIButton *_btnLogoRect;
    // 虚线
    UIImageView *_lineDashed;
    // 波浪线
    UIImageView *_lineWave;
    // 名称
    UILabel *_labTitle;
    // 地址
    UILabel *_labAddress;
    // 条形码
    UIImageView *_imgCoupon;
    // 使用描述
    UILabel *_labCouponDesc;
    // 如何使用
    UILabel *_labCouponUseDesc;
    // 横线
    UIView *_lineView;
    // 分享按钮
    UIButton *_btnShare;
    // 保存按钮
    UIButton *_saveToAlbum;
}

@end

@implementation CouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    [self setTitle:@"优惠券"];
    [self buildUI];
    
    
}
-(void)buildUI{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
