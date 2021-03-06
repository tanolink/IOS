//
//  NSDictionary+Uitls.h
//  Zouni
//
//  Created by Aokuny on 14-10-17.
//  Copyright (c) 2015年 Zouni. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString * const kEmptyString;
@interface NSDictionary (Uitls)
-(CGFloat )floatForKey:(id)key;
// return an empty string if the value is NSNull or not a string.
- (NSString *)stringForKey:(id)key;

//return nil if the object is NSNull or not a NSDictionary
- (NSDictionary *)dictionaryForKey:(id)key;

//return nil if the object is null or not a NSArray.
- (NSArray *)arrayForKey:(id)key;
- (BOOL)boolForKey:(id)key;
@end
