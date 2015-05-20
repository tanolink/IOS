//
//  CTCBar.h
//  BadgeBtnTest
//
//  Created by huchu on 14/10/27.
//  Copyright (c) 2014年 huchu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNAppUtil.h"

@interface CTCBar : UIView
@property(nonatomic,strong) UIButton *btnStyle;
-(id)initWithFrame:(CGRect)frame andArrData:(NSArray *)arrData bSpera:(BOOL)bSepra andBlock:(void (^)(NSUInteger idx))block;

@end
