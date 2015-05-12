//
//  ZNAppDelegate.h
//  Zouni
//
//  Created by Aokuny on 14-9-16.
//  Copyright (c) 2015年 Zouni. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MainViewController.h"

@interface ZNAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *mainViewController;

//@property (nonatomic,readonly) AGViewDelegate *viewDelegate;

@end
