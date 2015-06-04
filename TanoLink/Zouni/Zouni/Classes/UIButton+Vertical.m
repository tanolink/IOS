//
//  UIButton+Vertical.m
//  JuranClient
//
//  Created by Marin on 14-9-28.
//  Copyright (c) 2014年 juran. All rights reserved.
//

#import "UIButton+Vertical.h"
#import "UIImage-Helpers.h"
#import "ZNAppUtil.h"
@implementation UIButton (Vertical)
+(UIButton *)buttonWithBounds:(CGRect)bounds iconImage:(NSString *)iconImgStr iconTitle:(NSString *)titleStr {
    UIButton *iconBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [iconBtn setBounds:bounds];
    
    [iconBtn setAdjustsImageWhenHighlighted:NO];
    UIImage *highlightImage = [UIImage imageWithColor:[UIColor colorWithWhite:0.912 alpha:0.660]];
    [iconBtn setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    
    [iconBtn setTitle:titleStr forState:UIControlStateNormal];
    [iconBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    iconBtn.titleLabel.font = DEFAULT_FONT(14);
    
    UIImage *iconImg =[UIImage imageNamed:iconImgStr];
    [iconBtn setImage:iconImg forState:UIControlStateNormal];
    
    CGSize iconSize = iconImg.size;
    CGFloat topMargin = (bounds.size.height - (iconBtn.titleLabel.frame.size.height + 1 + iconSize.height)) / 2.f ;
    
    [iconBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [iconBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    
    [iconBtn setImageEdgeInsets:UIEdgeInsetsMake(topMargin, (CGRectGetWidth(iconBtn.bounds)-iconSize.width)/2.0f, 0, 0)];
    [iconBtn setTitleEdgeInsets:UIEdgeInsetsMake(iconSize.height+ 5 + topMargin, -iconSize.width, 0, 0)];
    
    return iconBtn;
}



@end
