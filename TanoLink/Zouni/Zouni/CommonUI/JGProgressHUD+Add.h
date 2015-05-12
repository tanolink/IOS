//
//  JGProgressHUD+Add.h
//  Zouni
//
//  Created by Marin on 14-9-23.
//  Copyright (c) 2015年 Zouni. All rights reserved.
//

#import "JGProgressHUD.h"

@interface JGProgressHUD (Add)

+(void)showHintStr:(NSString *)hintStr;

+(void)showHintTitle:(NSString *)title hintStr:(NSString *)hintStr;

+(void)showErrorStr:(NSString *)errStr;

+(void)showSuccessStr:(NSString *)successStr;

@end
