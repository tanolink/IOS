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
    UIButton *_BtnShopCount;
    UIButton *_imgView;
    CityModel *_gCityModel;
}
-(void) setCellDataForModel:(CityModel *) cityModel{
    _gCityModel = cityModel;
    [_LabCityNameCN setText:cityModel.CityNameCN];
    [_LabCityNameEN setText:cityModel.CityNameEN];
    [_BtnShopCount setTitle:[NSString stringWithFormat:@"%@家商场",cityModel.ShopCount] forState:UIControlStateNormal];
    
    NSURL *caseurl = [NSURL URLWithString:cityModel.CityPhoto];
    [_imgView sd_setBackgroundImageWithURL:caseurl forState:UIControlStateNormal
                         placeholderImage:[UIImage imageNamed:@"default_userhead"]];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _LabCityNameCN = [[UILabel alloc]initWithFrame:CGRectZero];
        [_LabCityNameCN setFont:DEFAULT_BOLD_FONT(17)];
        [_LabCityNameCN setNumberOfLines:0];
        [_LabCityNameCN setTextColor:[UIColor whiteColor]];
        [_LabCityNameCN setLineBreakMode:NSLineBreakByTruncatingTail];
        //设置阴影
        _LabCityNameCN.shadowColor = [UIColor blackColor];
        _LabCityNameCN.shadowOffset = CGSizeMake(1.0,1.0);
//        _LabCityNameCN.layer.shadowOpacity = 0.1;
        
        _LabCityNameEN = [[UILabel alloc]initWithFrame:CGRectZero];
        [_LabCityNameEN setFont:DEFAULT_FONT(10)];
        [_LabCityNameEN setTextColor:[UIColor whiteColor]];
        [_LabCityNameEN setNumberOfLines:0];
        [_LabCityNameEN setLineBreakMode:NSLineBreakByTruncatingTail];
        //设置阴影
        _LabCityNameEN.shadowColor = [UIColor blackColor];
        _LabCityNameEN.shadowOffset = CGSizeMake(1.0,1.0);
        
        _BtnShopCount = [[UIButton alloc]initWithFrame:CGRectZero];
        [_BtnShopCount.titleLabel setFont:DEFAULT_FONT(9)];
        [_BtnShopCount.titleLabel setTintColor:[UIColor whiteColor]];
        [_BtnShopCount setBackgroundColor:[UIColor blackColor]];
        [_BtnShopCount.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        _BtnShopCount.layer.cornerRadius = 9;
        _BtnShopCount.alpha = 0.7;
        [_BtnShopCount.titleLabel setTintColor:[UIColor blackColor]];

        _imgView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_imgView setUserInteractionEnabled:NO];
        
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:_imgView];
        [self.contentView addSubview:_LabCityNameCN];
        [self.contentView addSubview:_LabCityNameEN];
        [self.contentView addSubview:_BtnShopCount];
        
        // test color
//        [_LabCityNameCN setBackgroundColor:[UIColor greenColor]];
//        [_LabCityNameEN setBackgroundColor:[UIColor redColor]];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];

    [_LabCityNameCN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(18);
        make.left.equalTo(self.contentView).offset(30/2);
    }];
    [_LabCityNameEN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_LabCityNameCN.mas_bottom).offset(2);
        make.left.equalTo(_LabCityNameCN);
    }];
    [_BtnShopCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-5);
        make.top.equalTo(self.contentView).offset(20);
        make.width.equalTo(@55);
        make.height.equalTo(@18);
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
