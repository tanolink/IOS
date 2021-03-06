//
//  ZNBaseNavigationController.m
//  Zouni
//
//  Created by Aokuny on 14-9-16.
//  Copyright (c) 2015年 Zouni. All rights reserved.
//

#import "ZNBaseNavigationController.h"
#import "ZNAppUtil.h"
#import "UIColor+AppColor.h"
@interface ZNBaseNavigationController ()

@end

@implementation ZNBaseNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
//
//    self.delegate = self;
//    UIImage *image = nil;
//    if (JRSystemVersionGreaterOrEqualThan(7.0)) {
//        [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
//         [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackTranslucent ];
//        
//        NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary: [[UINavigationBar appearance] titleTextAttributes]];
//        [titleBarAttributes setValue:DEFAULT_BOLD_FONT(16) forKey:UITextAttributeFont];
//        [[UINavigationBar appearance] setTitleTextAttributes:titleBarAttributes];
//
//    } else {
//        image = [UIImage imageNamed:@"titleBar"];
//        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleBlackOpaque];
//    }
//    
//    if (image &&[self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
//        [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    }
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.interactivePopGestureRecognizer.delegate = self;
//    }
    
    
    self.delegate = self;
    UIImage *image = nil;
    if (JRSystemVersionGreaterOrEqualThan(7.0)) {
        //        [[UINavigationBar appearance] setBarTintColor:RGBCOLOR(28,161,230)];
        [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
        
        //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigation_bar_background"] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackTranslucent];
        //self.navigationBar.translucent = NO;
        
        NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary: [[UINavigationBar appearance] titleTextAttributes]];
        [titleBarAttributes setValue:DEFAULT_BOLD_FONT(18) forKey:UITextAttributeFont];
        [[UINavigationBar appearance] setTitleTextAttributes:titleBarAttributes];
        
    } else {
        image = [UIImage imageNamed:@"titleBar"];
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    }
    
    if (image &&[self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //self.interactivePopGestureRecognizer.delegate = self;
    }
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (self.viewControllers.count>=2) {
        return YES;
    }else{
        return NO;
    }
}

/*隐藏tab栏*/
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count==1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
