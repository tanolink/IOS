//
//  ChineseToPinyin.h
//  Zouni
//
//  Created by Aokuny on 14-10-13.
//  Copyright (c) 2015年 Zouni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChineseToPinyin : NSObject {
    
}

+ (NSString *) pinyinFromChineseString:(NSString *)string;
+ (char) sortSectionTitle:(NSString *)string; 

@end