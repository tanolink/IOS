//
//  CellCityList.m
//  城市列表显示列
//
//  Created by aokuny on 15/5/13.
//  Copyright (c) 2015年 TonaLink. All rights reserved.
//

#import "CellCityList.h"

@implementation CellCityList{
    UILabel *_LabCityNameCN;
    UILabel *_LabCityNameEN;
    UILabel *_LabShopCount;
    CityModel *gCityModel;
}
-(void) setCellDataForModel:(CityModel *) cityModel{
    gCityModel = cityModel;
    [_LabCityNameCN setText:cityModel.cityNameCN];
    [_LabCityNameEN setText:cityModel.cityNameEN];
    [_LabShopCount setText:cityModel.shopCount];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _LabCityNameCN = [[UILabel alloc]initWithFrame:CGRectZero];
        [_LabCityNameCN setFont:DEFAULT_FONT(15)];
        [_LabCityNameCN setNumberOfLines:0];
        [_LabCityNameCN setLineBreakMode:NSLineBreakByTruncatingTail];
        
        _LabCityNameEN = [[UILabel alloc]initWithFrame:CGRectZero];
        [_LabCityNameEN setFont:DEFAULT_FONT(13)];
        _LabCityNameEN.textColor = [UIColor grayColor];
        [_LabCityNameEN setNumberOfLines:0];
        [_LabCityNameEN setLineBreakMode:NSLineBreakByTruncatingTail];
        
        _LabShopCount = [[UILabel alloc]initWithFrame:CGRectZero];
        [_LabShopCount setFont:DEFAULT_FONT(11)];
        _LabShopCount.textColor = RGBCOLOR(148,148,148);
        
        
//        _imgUnRead = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"new_msg"]];
        
        [self.contentView setBackgroundColor:RGBCOLOR(240,240,240)];
        
        [self.contentView addSubview:_LabCityNameCN];
        [self.contentView addSubview:_LabCityNameEN];
        [self.contentView addSubview:_LabShopCount];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    float fullwidth = self.contentView.frame.size.width;
    float magrin = 10 ;
    float separationV = 2;
    [_LabCityNameCN setFrame:CGRectMake(magrin,magrin,fullwidth-magrin*2,20)];
    [_LabCityNameEN setFrame:CGRectMake(magrin,CGRectGetMaxY(_LabCityNameCN.frame)+separationV,fullwidth,13)];
    [_LabShopCount setFrame:CGRectMake(magrin,magrin,fullwidth-magrin*5,20)];
    
}

- (void)awakeFromNib {}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
