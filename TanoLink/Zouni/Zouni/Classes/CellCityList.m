//
//  CellCityList.m
//  城市列表显示列
//
//  Created by aokuny on 15/5/13.
//  Copyright (c) 2015年 TonaLink. All rights reserved.
//

#import "CellCityList.h"
#import "UIButton+WebCache.h"

@implementation CellCityList{
    UILabel *_LabCityNameCN;
    UILabel *_LabCityNameEN;
    UILabel *_LabShopCount;
    UIButton *_imgView;
    CityModel *_gCityModel;
}
-(void) setCellDataForModel:(CityModel *) cityModel{
    _gCityModel = cityModel;
    [_LabCityNameCN setText:cityModel.CityNameCN];
    [_LabCityNameEN setText:cityModel.CityNameEN];
    [_LabShopCount setText:cityModel.ShopCount];
    
    NSURL *caseurl = [NSURL URLWithString:cityModel.CityPhoto];
    [_imgView sd_setBackgroundImageWithURL:caseurl forState:UIControlStateNormal
                         placeholderImage:[UIImage imageNamed:@"default_userhead"]];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _LabCityNameCN = [[UILabel alloc]initWithFrame:CGRectZero];
        [_LabCityNameCN setFont:DEFAULT_BOLD_FONT(31.5/2)];
        [_LabCityNameCN setNumberOfLines:0];
        [_LabCityNameCN setTextColor:[UIColor whiteColor]];
        [_LabCityNameCN setLineBreakMode:NSLineBreakByTruncatingTail];
        //设置阴影
        _LabCityNameCN.shadowColor = [UIColor blackColor];
        _LabCityNameCN.shadowOffset = CGSizeMake(2.0,2.0);
        
        _LabCityNameEN = [[UILabel alloc]initWithFrame:CGRectZero];
        [_LabCityNameEN setFont:DEFAULT_FONT(18/2)];
        [_LabCityNameEN setTextColor:[UIColor whiteColor]];
        [_LabCityNameEN setNumberOfLines:0];
        [_LabCityNameEN setLineBreakMode:NSLineBreakByTruncatingTail];
        //设置阴影
        _LabCityNameEN.shadowColor = [UIColor blackColor];
        _LabCityNameEN.shadowOffset = CGSizeMake(2.0,2.0);
        
        _LabShopCount = [[UILabel alloc]initWithFrame:CGRectZero];
        [_LabShopCount setFont:DEFAULT_FONT(22.5/2)];
        [_LabShopCount setTextColor:[UIColor whiteColor]];
        
        _imgView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_imgView setUserInteractionEnabled:NO];
        
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:_imgView];
        [self.contentView addSubview:_LabCityNameCN];
        [self.contentView addSubview:_LabCityNameEN];
        [self.contentView addSubview:_LabShopCount];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    // 中文名称距离
    float magrin = 30/2 ;
    // 汉字和英文名称的间距
    float distance = 14/2;
    [_LabCityNameCN setFrame:CGRectMake(magrin,magrin,200,20)];
    [_LabCityNameEN setFrame:CGRectMake(magrin,CGRectGetMaxY(_LabCityNameCN.frame) + distance,200,20)];
//    [_LabShopCount setFrame:CGRectMake(magrin,magrin,fullwidth-magrin*5,20)];
    
    [_LabShopCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-30/2);
        make.top.equalTo(self.contentView).offset(30/2);
        make.width.equalTo(@50);
    }];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
}

- (void)awakeFromNib {}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
