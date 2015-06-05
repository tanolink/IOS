//
//  TopTabBar.h
//  Zouni
//
//  Created by aokuny on 15/6/4.
//  Copyright (c) 2015年 juran. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ZNAppUtil.h"

@interface TopTabBar : UIView
@property(nonatomic,strong) UIButton *btnStyle;
-(id)initWithFrame:(CGRect)frame andArrData:(NSArray *)arrData bSpera:(BOOL)bSepra andBlock:(void (^)(NSUInteger idx))block;

@end
