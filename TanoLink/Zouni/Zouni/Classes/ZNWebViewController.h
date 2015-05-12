//
//  ZNWebViewController.h
//  JuranClient
//
//  Created by Marin on 14-9-28.
//  Copyright (c) 2014年 juran. All rights reserved.
//

#import "ZNBaseViewController.h"
#import "LoginBaseViewController.h"
@interface ZNWebViewController : ZNBaseViewController <UIWebViewDelegate>
- (ZNWebViewController *)initWithHTML:(NSString *)html;
- (ZNWebViewController *)initWithUrl:(NSString *)url;
@property (nonatomic, strong)NSString *titleStr;
@end
