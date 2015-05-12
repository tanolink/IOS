//
//  MainViewController.m
//  JuranClient
//
//  Created by Marin on 14-9-16.
//  Copyright (c) 2014年 juran. All rights reserved.
//

#import "MainViewController.h"
#import "ZNBaseNavigationController.h"
#import "ZNClientInfo.h"
//#import "LoginViewController.h"
#import "ZNAppUtil.h"
//#import "PersonalViewController.h"
//#import "CaseViewController.h"
//#import "DesignerListViewController.h"
//#import "PublishDesignViewController.h"
@interface MainViewController ()
@property (nonatomic, strong) ZNBaseNavigationController *casePageNavController;
@property (nonatomic, strong) ZNBaseNavigationController *subjectPageNavController;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    
    if (!JRSystemVersionGreaterOrEqualThan(7.0)) {
        self.tabBar.backgroundImage = [[UIImage imageNamed:@"tabbarBackground"] stretchableImageWithLeftCapWidth:25 topCapHeight:25];
        
    }
    
    NSArray *tarbarItems = @[@{@"title":@"案例",@"imgStr":@"tabbar_case",@"imgHlStr":@"tabbar_case_hl"},
                             @{@"title":@"专题",@"imgStr":@"tabbar_subject",@"imgHlStr":@"tabbar_subject_hl"},
                             @{@"title":@"发布需求",@"imgStr":@"tabbar_demands",@"imgHlStr":@"tabbar_demands_hl"},
                             @{@"title":@"设计师",@"imgStr":@"tabbar_designer",@"imgHlStr":@"tabbar_designer_hl"},
                             @{@"title":@"个人中心",@"imgStr":@"tabbar_personal",@"imgHlStr":@"tabbar_personal_hl"}];
//    /*案例*/
//    CaseViewController *casePageVC = [[CaseViewController alloc]init];
//    ZNBaseNavigationController *casePageNavController =[[ZNBaseNavigationController alloc]initWithRootViewController:casePageVC];
//    self.casePageNavController = casePageNavController;
//    
//    /*专题*/
//    UIViewController *subjectPageVC =[[UIViewController alloc]init];
//    ZNBaseNavigationController *subjectPageNavController =[[ZNBaseNavigationController alloc]initWithRootViewController:subjectPageVC];
//    self.subjectPageNavController = subjectPageNavController;
//    
//    /*发布需求*/
//    PublishDesignViewController *demandsPageVC =[[PublishDesignViewController alloc]init];
//    ZNBaseNavigationController *demandsPageNavController =[[ZNBaseNavigationController alloc]initWithRootViewController:demandsPageVC];
//    /*self.demandsPageNavController = demandsPageNavController;*/
//    
//    /*设计师*/
//    DesignerListViewController *designerPageVC =[[DesignerListViewController alloc]init];
//    designerPageVC.controllerType = kDesignerTypeAll;
//    ZNBaseNavigationController *designerPageNavController =[[ZNBaseNavigationController alloc]initWithRootViewController:designerPageVC];
//    /*self.designerPageNavController = designerPageNavController;*/
//    
//    /*个人中心*/
//    PersonalViewController *personalPageVC =[[PersonalViewController alloc]init];
//    ZNBaseNavigationController *personalPageNavController =[[ZNBaseNavigationController alloc]initWithRootViewController:personalPageVC];
//    
//    self.viewControllers = @[casePageNavController, subjectPageNavController,demandsPageNavController,designerPageNavController,personalPageNavController];
    
    for (NSUInteger index=0; index<=4; index++) {
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
    
    // 设置默认的图片加载
    if ([ZNClientInfo isIntelligence] == nil) {
        ZNClientInfo *clientInfo = [[ZNClientInfo alloc]init];
        // 自动
        [clientInfo saveIntelligence:@"ON"];
        [clientInfo saveImageQualityType:Common];
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
