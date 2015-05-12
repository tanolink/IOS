//
//  BaseTableView.m
//  Zouni
//
//  Created by Aokuny on 14/10/20.
//  Copyright (c) 2015年 Zouni. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self initTableView];
    }
    return self;
}

-(void)initTableView {

    self.backgroundColor = [UIColor whiteColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight;

    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    self.tableFooterView = [[UIView alloc] init];
    self.showsVerticalScrollIndicator = NO;
}
@end
