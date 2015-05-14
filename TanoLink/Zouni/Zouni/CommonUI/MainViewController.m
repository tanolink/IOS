//
//  MainViewController.m
//  Zouni 主页面（店铺列表）
//
//  Created by Marin on 14-9-16.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "MainViewController.h"
#import "ZNBaseNavigationController.h"
#import "ZNClientInfo.h"
#import "ZNAppUtil.h"
#import "CityListViewController.h"
#import "StrategyViewController.h"
#import "ToolViewController.h"
#import "MyCenterViewController.h"
#import "ShopListViewController.h"

@interface MainViewController ()
@property (nonatomic, strong) ZNBaseNavigationController *cityListNavController;
//@property (nonatomic, strong) ZNBaseNavigationController *subjectPageNavController;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    
    if (!JRSystemVersionGreaterOrEqualThan(7.0)) {
        self.tabBar.backgroundImage = [[UIImage imageNamed:@"tabbarBackground"] stretchableImageWithLeftCapWidth:25 topCapHeight:25];
    }
    
    NSArray *tarbarItems = @[@{@"title":@"发现",@"imgStr":@"tabbar_case",@"imgHlStr":@"tabbar_case_hl"},
                             @{@"title":@"攻略",@"imgStr":@"tabbar_subject",@"imgHlStr":@"tabbar_subject_hl"},
                             @{@"title":@"工具",@"imgStr":@"tabbar_demands",@"imgHlStr":@"tabbar_demands_hl"},
                             @{@"title":@"我的",@"imgStr":@"tabbar_designer",@"imgHlStr":@"tabbar_designer_hl"}];
    
    ShopListViewController *shopListVC = [[ShopListViewController alloc]init];
    ZNBaseNavigationController *shopListNavController = [[ZNBaseNavigationController alloc]initWithRootViewController:shopListVC];
    
    StrategyViewController *strategyViewController = [[StrategyViewController alloc]init];
    ZNBaseNavigationController *strategyNavController = [[ZNBaseNavigationController alloc]initWithRootViewController:strategyViewController];

    ToolViewController *toolVC = [[ToolViewController alloc]init];
    ZNBaseNavigationController *toolNavController = [[ZNBaseNavigationController alloc]initWithRootViewController:toolVC];
    
    MyCenterViewController *myCenterVC = [[MyCenterViewController alloc]init];
    ZNBaseNavigationController *myCenterNavController = [[ZNBaseNavigationController alloc]initWithRootViewController:myCenterVC];
    
    self.viewControllers = @[shopListNavController,strategyNavController,toolNavController,myCenterNavController];
    
    for (NSUInteger index=0; index<4; index++) {
        NSDictionary *tarbarItem = [tarbarItems objectAtIndex:index];
        UINavigationController *navController = self.viewControllers[index];
        UIImage *normalImage = [UIImage imageNamed:tarbarItem[@"imgStr"]];
        UIImage *selectImage = [UIImage imageNamed:tarbarItem[@"imgHlStr"]];
        [navController.tabBarItem setFinishedSelectedImage:selectImage withFinishedUnselectedImage:normalImage];
        navController.tabBarItem.title = tarbarItem[@"title"];
        navController.tabBarItem.tag = index;
        UIOffset offset = [navController.tabBarItem titlePositionAdjustment];
        [navController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(offset.horizontal, offset.vertical - 3.f)];
        navController.tabBarItem.imageInsets = UIEdgeInsetsMake(-3.f, 0, 3.f, 0);
        [self unSelectedTapTabBarItems:navController.tabBarItem];
        [self selectedTapTabBarItems:navController.tabBarItem];
    }
    
}

-(void)unSelectedTapTabBarItems:(UITabBarItem *)tabbarItem
{
    [tabbarItem setTitleTextAttributes:@{NSFontAttributeName: DEFAULT_FONT(11), NSForegroundColorAttributeName:[UIColor blackColor] } forState:UIControlStateNormal ];
    
}

-(void)selectedTapTabBarItems:(UITabBarItem *)tabbarItem
{
    [tabbarItem setTitleTextAttributes:@{NSFontAttributeName: DEFAULT_FONT(11), NSForegroundColorAttributeName:[UIColor colorWithRed:0.068 green:0.331 blue:0.641 alpha:1.000] } forState:UIControlStateSelected];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITabBarControllerDelegate methods
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([ZNClientInfo isLogin]) {
        return YES;
    } else {
        if (viewController.tabBarItem.tag == 4) {
            
//            __block ZNBaseNavigationController *currentNavController = (ZNBaseNavigationController *) [tabBarController.viewControllers objectAtIndex:tabBarController.selectedIndex];
//            __block ZNBaseNavigationController *willToNavController = (ZNBaseNavigationController*)viewController;
//            __block UITabBarController*weakTabBarController = tabBarController;
//            LoginViewController *loginVC = [[LoginViewController alloc]init];
//            [loginVC setCompletionBlockWithLoginSuccess:^(LoginViewController *loginVC, NSDictionary *info) {
//                [weakTabBarController setSelectedViewController:willToNavController];
//            } Cancel:^(LoginViewController *loginVC, NSDictionary *info) {
//                
//            }];
//            ZNBaseNavigationController *loginNav = [[ZNBaseNavigationController alloc]initWithRootViewController:loginVC];
//            [currentNavController presentViewController:loginNav animated:YES completion:nil];
            return NO;
        }
    }
    return YES;

}


@end
