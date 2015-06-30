//
//  ShopModel.h
//  Zouni
//
//  Created by aokuny on 15/5/16.
//  Copyright (c) 2015年 TanoLin. All rights reserved.
//

#import "JSONModel.h"
@protocol ShopModel
@end
@interface ShopModel : JSONModel
@property (nonatomic, strong) NSString <Optional>*ShopID;
@property (nonatomic, strong) NSString <Optional>*desc;
@property (nonatomic, strong) NSString <Optional>*Score;
@property (nonatomic, strong) NSString <Optional>*Coupon;
@property (nonatomic, strong) NSString <Optional>*ShopPhone;
@property (nonatomic, strong) NSString <Optional>*Translate;
@property (nonatomic, strong) NSString <Optional>*ShopClass;
@property (nonatomic, strong) NSString <Optional>*Address;
@property (nonatomic, strong) NSString <Optional>*PX;
@property (nonatomic, strong) NSString <Optional>*ShopName;
@property (nonatomic, strong) NSString <Optional>*ShopENName;
@property (nonatomic, strong) NSArray <Optional>*Images;
//@property (nonatomic, strong) NSString <Optional>*Comments;
//@property (nonatomic, strong) NSArray <CommentModel,Optional> *Comments;
//@property (nonatomic, strong) CommentsList <Optional> *Comments;
@property (nonatomic, strong) NSString <Optional>*PY;
@property (nonatomic, strong) NSString <Optional>*FavoriteStatus;
@property (nonatomic, strong) NSString <Optional>*JSLocation;
@property (nonatomic, strong) NSString <Optional>*hours;
@property (nonatomic, strong) NSString <Optional>*website;
@property (nonatomic, strong) NSString <Optional>*distance;
@property (nonatomic, strong) NSString <Optional>*Route;
@property (nonatomic, strong) NSString <Optional>*ReviewCount;
@end


