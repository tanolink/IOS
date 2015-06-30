//
//  CommentModel.h
//  Zouni
//
//  Created by aokuny on 15/6/27.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "JSONModel.h"

@protocol CommentModel
@end

@interface CommentModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*UserName;
@property (nonatomic, strong) NSString <Optional>*CommentId;
@property (nonatomic, strong) NSString <Optional>*UserId;
@property (nonatomic, strong) NSString <Optional>*userPhoto;
@property (nonatomic, strong) NSString <Optional>*Time;
@property (nonatomic, strong) NSString <Optional>*Content;
@property (nonatomic, strong) NSString <Optional>*Score;
@property (nonatomic, strong) NSArray <Optional>*Images;
@end
//// 评论列表
//@interface CommentsList :JSONModel
//@property (nonatomic,strong) NSArray<CommentModel> *Comments;
//@end