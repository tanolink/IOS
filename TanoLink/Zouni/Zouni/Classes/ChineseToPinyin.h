//
//  ChineseToPinyin.h
//  JuranClient
//
//  Created by huchu on 14-10-13.
//  Copyright (c) 2014年 juran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChineseToPinyin : NSObject {
    
}

+ (NSString *) pinyinFromChineseString:(NSString *)string;
+ (char) sortSectionTitle:(NSString *)string; 

@end