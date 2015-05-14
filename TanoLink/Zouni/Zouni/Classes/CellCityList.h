//
//  CellCityList.h
//  Zouni
//
//  Created by aokuny on 15/5/13.
//  Copyright (c) 2015年 juran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityListModel.h"
#import "ZNAppUtil.h"

@interface CellCityList : UITableViewCell
-(void) setCellDataForModel:(CityModel *)cityModel;
@end
