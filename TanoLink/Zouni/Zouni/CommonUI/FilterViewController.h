//
//  FilterViewController.h
//
//  Created by aokuny on 14/10/28.
//  Copyright (c) 2014年. All rights reserved.
//

#import "ZNBaseViewController.h"
#define kNULLROWV @"NULLROWV"
@class FilterViewController;
@protocol FilterViewControllerDelegate <NSObject>

@optional
-(void)filterViewClose:(NSMutableDictionary *)resultDic;

@end
@interface FilterViewController : ZNBaseViewController
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, weak) id<FilterViewControllerDelegate> delegate;
@property (nonatomic, strong) NSMutableDictionary *chocieDic;

@end
