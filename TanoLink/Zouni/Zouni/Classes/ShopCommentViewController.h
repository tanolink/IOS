//
//  ShopCommentViewController.h
//  点评列表
//
//  Created by aokuny on 15/6/25.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "ZNBaseViewController.h"
#import "CellCommentTableViewCell.h"

@interface ShopCommentViewController : ZNBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)   NSMutableArray *dataMutableArray;
@end
