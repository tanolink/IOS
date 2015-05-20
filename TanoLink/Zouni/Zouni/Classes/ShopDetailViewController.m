//
//  ShopDetailViewController.m
//  Zouni
//
//  Created by aokuny on 15/5/17.
//  Copyright (c) 2015年 juran. All rights reserved.
//

#import "ShopDetailViewController.h"

@interface ShopDetailViewController ()

@end

@implementation ShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self showHudInView:self.view hint:nil];
//    __weak typeof(self) weakSelf = self;
    NSDictionary *requestDic = [[NSDictionary alloc]initWithObjectsAndKeys:@"4",@"shopId",nil];
    [ZNApi invokePost:ZN_SHOPDETAIL_API parameters:requestDic completion:^(id resultObj,NSString *msg,ZNRespModel *respModel) {
        if (resultObj) {
            NSArray *dic = (NSArray *)resultObj;
            NSLog(@"%@",dic);
        }
//        [weakSelf hideHud];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
