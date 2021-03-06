//
//  ZNBaseViewController.h
//  Zouni
//
//  Created by Aokuny on 14-9-16.
//  Copyright (c) 2015年 Zouni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+HUD.h"
#import "ZNApi.h"
#import "ZNAppUtil.h"
#import "BaseLabel.h"
#import "BaseTableView.h"
#import "BaseTableViewCell.h"
@interface ZNBaseViewController : UIViewController

- (void)setBackBarButton;
- (void)setRightBarSystemButtonItemTitle:(NSString *)aTitle target:(id)target action:(SEL)action;

- (void)setRightBarButtonItemTitle:(NSString *)aTitle target:(id)target action:(SEL)action;
- (void)setRightBarButtonItemImage:(NSString *)imageName target:(id)target action:(SEL)action;
- (void)setBackBarButtonItemTitle:(NSString *)aTitle target:(id)target action:(SEL)action;
- (void)setBackBarButtonItemImage:(NSString *)imageName target:(id)target action:(SEL)action;
- (void)setNavTitle:(NSString *)title;
-(void)setNavTitle:(NSString *)title titleColor:(UIColor *)titleColor;

- (UIButton *)buttonWithTitle:(NSString*)aTitle image:(UIImage*)image highligted:(UIImage*)highligteImage target:(id)target action:(SEL)action;
-(void)setupRefreshForTableView:(UITableView *)tableView;

-(void)setupRefreshForCollectionView:(UICollectionView *) collectionView;

-(void)setLogBackBarButton;
-(void)setLogBackBarButton:(BOOL)isNeedSender;
-(void)setLogBackBarButton:(NSString *)imgStr target:(id)target action:(SEL)action;
-(void)setNoLogBackBarButton;
-(void)rightAction;
-(void) createLineByWidth:(float) width withParentContainer:(UIView *)paretView;

@end
