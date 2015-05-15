//
//  ShopListViewController.m
//  店铺列表
//
//  Created by aokuny on 15/5/13.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "ShopListViewController.h"
#import "GoogleMapViewController.h"

@interface ShopListViewController ()

@end

@implementation ShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBarButton];
    [self setTitle:self.cityModel.CityNameCN];
    
    [self setRightBarButtonItemTitle:@"地图" target:self action:@selector(pushToGoogleMap)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) pushToGoogleMap{
    GoogleMapViewController *gooleMapVC = [[GoogleMapViewController alloc]init];
    [self.navigationController pushViewController:gooleMapVC animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
