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
@end

@implementation MainViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self BackButton];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    [self setTitle:@"走你"];

    NSArray *tarbarItems = @[@{@"title":@"发现",@"imgStr":@"tab01_a",@"imgHlStr":@"tab01_b"},
                             @{@"title":@"攻略",@"imgStr":@"tab02_a",@"imgHlStr":@"tab02_b"},
                             @{@"title":@"工具",@"imgStr":@"tab03_a",@"imgHlStr":@"tab03_b"},
                             @{@"title":@"我的",@"imgStr":@"tab04_a",@"imgHlStr":@"tab04_b"}];
    
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
//        navController.tabBarItem.imageInsets = UIEdgeInsetsMake(-3.f, 0, 3.f, 0);
        navController.tabBarItem.imageInsets = UIEdgeInsetsMake(3,3,3,3);
        [self unSelectedTapTabBarItems:navController.tabBarItem];
        [self selectedTapTabBarItems:navController.tabBarItem];
    }
    
}

-(void) BackButton {
    NSString *aTitle = self.cityModel.CityNameCN;
    UIFont * font=DEFAULT_FONT(13);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize size = [aTitle sizeWithFont:font constrainedToSize:CGSizeMake(ScreenWidth, 30)];
    CGRect rect = CGRectMake(0, 0, size.width, 30);
    UIImage *image = [UIImage imageNamed:@""];
    if (image) {
        rect = CGRectMake(0, 0, MIN(22.f,  image.size.width)/*25.f*/, MIN( image.size.height,22.f )/*25.f*/);
    }
    button.frame = rect;
    [button setTitle:aTitle forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button setTitleColor:[UIColor colorWithWhite:1.000 alpha:1.000] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.953 green:0.948 blue:0.959 alpha:1.000] forState:UIControlStateHighlighted];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    //    [button setBackgroundImage:highligteImage forState:UIControlStateHighlighted];
    button.imageView.contentMode = UIViewContentModeScaleToFill;
    [button addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}


-(void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
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
//    if ([ZNClientInfo isLogin]) {
//        return YES;
//    } else {
//        if (viewController.tabBarItem.tag == 4) {
//            
////            __block ZNBaseNavigationController *currentNavController = (ZNBaseNavigationController *) [tabBarController.viewControllers objectAtIndex:tabBarController.selectedIndex];
////            __block ZNBaseNavigationController *willToNavController = (ZNBaseNavigationController*)viewController;
////            __block UITabBarController*weakTabBarController = tabBarController;
////            LoginViewController *loginVC = [[LoginViewController alloc]init];
////            [loginVC setCompletionBlockWithLoginSuccess:^(LoginViewController *loginVC, NSDictionary *info) {
////                [weakTabBarController setSelectedViewController:willToNavController];
////            } Cancel:^(LoginViewController *loginVC, NSDictionary *info) {
////                
////            }];
////            ZNBaseNavigationController *loginNav = [[ZNBaseNavigationController alloc]initWithRootViewController:loginVC];
////            [currentNavController presentViewController:loginNav animated:YES completion:nil];
//            return NO;
//        }
//    }
    return YES;

}


@end
