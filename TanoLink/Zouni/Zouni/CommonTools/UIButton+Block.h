//
//  UIButton+Block.h
//  JuranClient
//
//  Created by aokuny on 14/11/5.
//  Copyright (c) 2014年 juran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


typedef void (^ActionBlock)();

@interface UIButton(Block)

@property (readonly) NSMutableDictionary *event;

- (void) handleControlEvent:(UIControlEvents)controlEvent withBlock:(ActionBlock)action;

@end
