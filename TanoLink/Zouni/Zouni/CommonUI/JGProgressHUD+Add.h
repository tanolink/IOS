//
//  JGProgressHUD+Add.h
//  JuranClient
//
//  Created by Marin on 14-9-23.
//  Copyright (c) 2014年 juran. All rights reserved.
//

#import "JGProgressHUD.h"

@interface JGProgressHUD (Add)

+(void)showHintStr:(NSString *)hintStr;

+(void)showHintTitle:(NSString *)title hintStr:(NSString *)hintStr;

+(void)showErrorStr:(NSString *)errStr;

+(void)showSuccessStr:(NSString *)successStr;

@end
