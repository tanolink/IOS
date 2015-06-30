//
//  CellCommentTableViewCell.h
//  Zouni
//
//  Created by aokuny on 15/6/25.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
@interface CellCommentTableViewCell : UITableViewCell
@property(nonatomic,strong)     UILabel *labUserName;
-(void) setCellDataForModel:(CommentModel *) commentModel;
+(float)getCellHeightForModel:(CommentModel *) commentModel;
@end
