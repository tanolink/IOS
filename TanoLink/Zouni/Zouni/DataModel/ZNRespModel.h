//
//  JRResModel.h
//  Zouni
//
//  Created by Aokuny on 14-10-16.
//  Copyright (c) 2015年 Zouni. All rights reserved.
//

#import "JSONModel.h"

@interface ZNRespHeadModel : JSONModel
@property (nonatomic, strong) NSString *respCode;
@property (nonatomic, strong) NSString <Optional>*respShow;
@property (nonatomic, strong) NSString <Optional>*respDebug;
@end

@interface ZNRespModel : JSONModel
@property (nonatomic,strong) ZNRespHeadModel* respHead;
@property (nonatomic,strong) NSDictionary *respBody;
@end
