//
//  CTBView.h
//  Created by aokuny on 14/10/28.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNAppUtil.h"
#define kNULLROWV @"NULLROWV"
@class CTBView;

@protocol CTBViewDelegate <NSObject>

@optional
-(void)ctbChocie:(NSMutableDictionary *)valueStr withCTB:(UIView *)ctb;

@end

@interface CTBView : UIView
@property (nonatomic, weak) id< CTBViewDelegate > delegate;
@property (nonatomic, assign) BOOL isSingle;
+(CTBView*)showWindowWithArrData:(NSArray*)arraData insideView:(UIView*)view offSetY:(CGFloat)offSetY delegate:(id<CTBViewDelegate>)delegate;
-(void)closePopupWindow;
-(void)closePopupWindowNotBack;
- (id)initWithArrData:(NSArray*)arrData andOffSetY:(CGFloat)offSetY delegate:(id<CTBViewDelegate>)delegate;
-(void)showInView:(UIView*)v;
-(void)showInView:(UIView *)v andDefaultSel:(NSDictionary *)defaultSelV;/*默认选择value*/
@end
