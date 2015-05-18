//
//  MainViewController.h
//  Zouni
//
//  Created by Marin on 14-9-16.
//  Copyright (c) 2015年 Zouni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityListModel.h"

@interface MainViewController : UITabBarController <UITabBarControllerDelegate>
@property (nonatomic,strong) CityModel *cityModel;
@end
