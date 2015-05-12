//
//  ZNWebViewController.h
//  Zouni
//
//  Created by Aokuny on 14-9-28.
//  Copyright (c) 2015年 Zouni. All rights reserved.
//

#import "ZNBaseViewController.h"
#import "LoginBaseViewController.h"
@interface ZNWebViewController : ZNBaseViewController <UIWebViewDelegate>
- (ZNWebViewController *)initWithHTML:(NSString *)html;
- (ZNWebViewController *)initWithUrl:(NSString *)url;
@property (nonatomic, strong)NSString *titleStr;
@end
