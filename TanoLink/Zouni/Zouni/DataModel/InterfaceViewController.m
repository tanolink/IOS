//
//  InterfaceViewController.m
//  Zouni
//
//  Created by aokuny on 15/5/23.
//  Copyright (c) 2015年 juran. All rights reserved.
//

#import "InterfaceViewController.h"
#import "ZNAppUtil.h"

@interface InterfaceViewController ()

@end

@implementation InterfaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [ZNApi invokePost:ZN_CITYLIST_API parameters:nil completion:^(id resultObj,NSString *msg,ZNRespModel *respModel) {
//        if (resultObj) {
//            NSDictionary *dic = (NSDictionary *)resultObj;
//            
//        }
//    }];
    
//    // 接口  ZN_ADDFAVORITE_API
//    
//    // login
//    NSDictionary *requestDic = [[NSDictionary alloc]initWithObjectsAndKeys:
//                                @"tntshaka@gmail.com",@"email",@"888888",@"password",nil];
//    [ZNApi invokePost:ZN_LOGIN_API parameters:requestDic completion:^(id resultObj,NSString *msg,ZNRespModel *respModel) {
//        if (resultObj) {
//            NSDictionary *dic = (NSDictionary *)resultObj;
//            NSString *strKey = [NSString stringWithFormat:@"%@%@",[dic objectForKey:@"objectId"],DefautlKey];
//            NSString *strMd5  = [ZNAppUtil toMd5:strKey];
//            NSLog(@"============== %@",strMd5);
//            NSString *permit = [NSString stringWithFormat:@"%@,%@",[dic objectForKey:@"objectId"],strMd5];
//            NSLog(@"permit:%@",permit);
//            ZNApi.sharedInstance.headerPermit = permit;
//            [self beginInterfaceData];
//        }
//    }];
}
-(void) beginInterfaceData {
    NSDictionary *requestDic1 = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 @"4",@"shopId",nil];
    [ZNApi invokePost:ZN_ADDFAVORITE_API parameters:requestDic1 completion:^(id resultObj,NSString *msg,ZNRespModel *respModel) {
        if (resultObj) {
            NSArray *dic = (NSArray *)resultObj;
            NSLog(@"%@",dic);
        }
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
