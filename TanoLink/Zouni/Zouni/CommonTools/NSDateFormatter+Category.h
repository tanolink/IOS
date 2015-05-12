//
//  NSDateFormatter+Category.h
//  JuranClient
//
//  Created by huchu on 14-11-3.
//  Copyright (c) 2014年 juran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Category)

+ (id)dateFormatter;
+ (id)dateFormatterWithFormat:(NSString *)dateFormat;

+ (id)defaultDateFormatter;/*yyyy-MM-dd HH:mm:ss*/

@end
