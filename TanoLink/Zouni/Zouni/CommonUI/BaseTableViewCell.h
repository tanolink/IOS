//
//  BaseTableViewCell.h
//  Zouni
//
//  Created by Aokuny on 14-10-11.
//  Copyright (c) 2015年 Zouni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNAppUtil.h"
#import "UIImage-Helpers.h"
#define kEdgeInsetY  4

@protocol BaseTableCellDelegate;
@interface BaseTableViewCell : UITableViewCell
{
    UILongPressGestureRecognizer *_headerLongPress;
}

@property (weak, nonatomic) id<BaseTableCellDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) UIView *bottomLineView;

-(void)setCellDataDictionary:(NSDictionary *)cellDataDic;

@end

@protocol BaseTableCellDelegate <NSObject>

- (void)cellImageViewLongPressAtIndexPath:(NSIndexPath *)indexPath;

@end