//
//  BindEmailViewController.h
//  绑定邮箱
//
//  Created by aokuny on 15/5/31.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "ZNBaseViewController.h"

@interface BindEmailViewController : ZNBaseViewController<UITextFieldDelegate>
@property (nonatomic, strong) NSString *oldMobileStr;
@end
