//
//  SemiViewControllerCategory.h
//  JuranClient
//
//  Created by Aokuny on 14-10-9.
//  Copyright (c) 2014年 juran. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SemiViewController;

@interface UIViewController (SemiViewController)

@property (nonatomic, strong) SemiViewController *leftSemiViewController;
@property (nonatomic, strong) SemiViewController *rightSemiViewController;


@end
