//
//  CellShopList.m
//  Zouni
//
//  Created by aokuny on 15/5/16.
//  Copyright (c) 2015年 juran. All rights reserved.
//

#import "CellShopList.h"
#import "ShopModel.h"
#import "UIButton+WebCache.h"
#import "ShopDetailViewController.h"

@implementation CellShopList{
//    图片
    UIButton *_imgView;
//    图片遮罩
    UIView  *_shadeView;
//    名称
    UILabel *_labShopName;
//    评分
    UILabel *_labScore;
//    店铺类型
    UILabel *_labShopClass;
//  星星
    UIImageView *imgStarGray1;
    UIImageView *imgStarGray2;
    UIImageView *imgStarGray3;
    UIImageView *imgStarGray4;
    UIImageView *imgStarGray5;
//  星星数组
    NSMutableArray *_mutArrayStars;
//  按钮描述
    UILabel *_labShopDetail;
    UILabel *_labShopMap;
    UILabel *_labCoupon;
    
//  分割线
    UIImageView *imageSplit1;
    UIImageView *imageSplit2;
    
//  点评描述
    UILabel *_labDescription;
//  点评背景
    UIView *_viewDescBg;
}
- (void)awakeFromNib {}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void) setCellDataForModel:(ShopModel *) shopModel{
    [_labShopName setText:shopModel.ShopName];
//    [_labShopClass setText:shopModel.shopClass];  // 后台暂时没有分类，先使用英文名称
    [_labShopClass setText:shopModel.ShopENName];
    NSString *imageUrl = @"";
    if ([shopModel.Images count]>0) {
        imageUrl =shopModel.Images[0];
    }
    NSURL *caseurl = [NSURL URLWithString:imageUrl];
    [_imgView sd_setBackgroundImageWithURL:caseurl forState:UIControlStateNormal
                          placeholderImage:[UIImage imageNamed:@"default_userhead"]];
    //处理星星
    int stars = (int)[shopModel.Score integerValue];
    for (int i=0 ; i< stars ;i++) {
       UIImageView *imgV = (UIImageView*)_mutArrayStars[i];
        [imgV setImage:[UIImage imageNamed:@"xing02"]];
    }
    if(stars>0){
        [_labScore setText:[NSString stringWithFormat:@"%@分",shopModel.Score]];
    }else{
        [_labScore setText:@"0分"];
    }
    NSString *startStr = @"点评：";
    NSString *descContent = [NSString stringWithFormat:@"%@%@",startStr,shopModel.desc];
    NSRange startRange = [descContent rangeOfString:startStr];
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:descContent];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:4];
    [paragraphStyle1 setLineBreakMode:NSLineBreakByTruncatingTail];
    [attributedString1 setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],
                                       NSFontAttributeName:DEFAULT_FONT(10),
                                       NSParagraphStyleAttributeName:paragraphStyle1
                                       } range:startRange];
    [_labDescription setAttributedText:attributedString1];
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _labShopName = [[UILabel alloc]initWithFrame:CGRectZero];
        [_labShopName setFont:DEFAULT_FONT(12)];
        [_labShopName setNumberOfLines:0];
        [_labShopName setTextColor:[UIColor whiteColor]];
        [_labShopName setLineBreakMode:NSLineBreakByTruncatingTail];
        
        _labShopClass = [[UILabel alloc]initWithFrame:CGRectZero];
        [_labShopClass setFont:DEFAULT_FONT(10)];
        [_labShopClass setTextColor:[UIColor whiteColor]];
        [_labShopClass setNumberOfLines:0];
        [_labShopClass setLineBreakMode:NSLineBreakByTruncatingTail];
        
        _labScore = [[UILabel alloc]initWithFrame:CGRectZero];
        [_labScore setFont:DEFAULT_FONT(10)];
        [_labScore setTextColor:[UIColor whiteColor]];
        [_labScore setNumberOfLines:0];
        [_labScore setLineBreakMode:NSLineBreakByTruncatingTail];

        _imgView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_imgView setUserInteractionEnabled:NO];

        _shadeView = [[UIView alloc]initWithFrame:CGRectZero];
        _shadeView.backgroundColor = RGBCOLOR_WithAlpha(0,0,0,.4);
        
        imgStarGray1 = [[UIImageView alloc]initWithFrame:CGRectZero];
        [imgStarGray1 setImage:[UIImage imageNamed:@"xing01"]];
        [_shadeView addSubview:imgStarGray1];
        imgStarGray2 = [[UIImageView alloc]initWithFrame:CGRectZero];
        [imgStarGray2 setImage:[UIImage imageNamed:@"xing01"]];
        [_shadeView addSubview:imgStarGray2];
        imgStarGray3 = [[UIImageView alloc]initWithFrame:CGRectZero];
        [imgStarGray3 setImage:[UIImage imageNamed:@"xing01"]];
        [_shadeView addSubview:imgStarGray3];
        imgStarGray4 = [[UIImageView alloc]initWithFrame:CGRectZero];
        [imgStarGray4 setImage:[UIImage imageNamed:@"xing01"]];
        [_shadeView addSubview:imgStarGray4];
        imgStarGray5 = [[UIImageView alloc]initWithFrame:CGRectZero];
        [imgStarGray5 setImage:[UIImage imageNamed:@"xing01"]];
        [_shadeView addSubview:imgStarGray5];
        _mutArrayStars = [NSMutableArray arrayWithArray:@[imgStarGray1,imgStarGray2,imgStarGray3,imgStarGray4,imgStarGray5]];
        self._btnShopDetail = [[UIButton alloc]initWithFrame:CGRectZero];
        [self._btnShopDetail setImage:[UIImage imageNamed:@"list_icon01"] forState:UIControlStateNormal];
        _labShopDetail = [[UILabel alloc]initWithFrame:CGRectZero];
        [_labShopDetail setText:@"商家详情"];
        [_labShopDetail setFont:DEFAULT_FONT(11)];
        [_labShopDetail setTextAlignment:NSTextAlignmentCenter];
        [_labShopDetail setTextColor:RGBCOLOR(102,102,102)];
        
        self._btnShopMap = [[UIButton alloc]initWithFrame:CGRectZero];
        [self._btnShopMap setImage:[UIImage imageNamed:@"list_icon02"] forState:UIControlStateNormal];
        _labShopMap = [[UILabel alloc]initWithFrame:CGRectZero];
        [_labShopMap setText:@"地图"];
        [_labShopMap setFont:DEFAULT_FONT(11)];
        [_labShopMap setTextAlignment:NSTextAlignmentCenter];
        [_labShopMap setTextColor:RGBCOLOR(102,102,102)];

        self._btnCoupon = [[UIButton alloc]initWithFrame:CGRectZero];
        [self._btnCoupon setImage:[UIImage imageNamed:@"list_icon03"] forState:UIControlStateNormal];
        _labCoupon = [[UILabel alloc]initWithFrame:CGRectZero];
        [_labCoupon setText:@"领取优惠券"];
        [_labCoupon setFont:DEFAULT_FONT(11)];
        [_labCoupon setTextAlignment:NSTextAlignmentCenter];
        [_labCoupon setTextColor:RGBCOLOR(102,102,102)];
        
        _labDescription = [[UILabel alloc]initWithFrame:CGRectZero];
        [_labDescription setFont:DEFAULT_FONT(11)];
        [_labDescription setTextAlignment:NSTextAlignmentLeft];
        [_labDescription setNumberOfLines:0];
        [_labDescription setTextColor:ZN_FONNT_03_LIGHTGRAY];
        
        _viewDescBg = [[UIView alloc]initWithFrame:CGRectZero];
        [_viewDescBg setBackgroundColor:RGBCOLOR(240,240,240)];
        
        imageSplit1 = [[UIImageView alloc]initWithFrame:CGRectZero];
        [imageSplit1 setImage:[UIImage imageNamed:@"split"]];
        imageSplit2 = [[UIImageView alloc]initWithFrame:CGRectZero];
        [imageSplit2 setImage:[UIImage imageNamed:@"split"]];
        
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:_imgView];
        [_shadeView addSubview:_labShopName];
        [_shadeView addSubview:_labShopClass];
        [_shadeView addSubview:_labScore];
        [_shadeView addSubview:_labShopDetail];
        [_shadeView addSubview:_labShopMap];
        [_shadeView addSubview:_labCoupon];
        [_viewDescBg addSubview:_labDescription];
        
        [self.contentView addSubview:_shadeView];
        [self.contentView addSubview:self._btnCoupon];
        [self.contentView addSubview:self._btnShopMap];
        [self.contentView addSubview:self._btnShopDetail];
        [self.contentView addSubview:_viewDescBg];
        [self.contentView addSubview:imageSplit1];
        [self.contentView addSubview:imageSplit2];
        
        // corlor test
//        [_btnShopDetail setBackgroundColor:[UIColor orangeColor]];
//        [_btnShopMap setBackgroundColor:[UIColor redColor]];
        
//        [_labShopDetail setBackgroundColor:[UIColor purpleColor]];
//        [_labCoupon setBackgroundColor:[UIColor greenColor]];
        
//        [_labDescription setBackgroundColor:[UIColor orangeColor]];
//        [_labScore setBackgroundColor:[UIColor greenColor]];
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.equalTo(@(516/3-20));
    }];
    
    [_shadeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(_imgView.mas_bottom);
        make.height.equalTo(@(150/3-5));
    }];
    
    [_labShopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shadeView).offset(24/3);
        make.left.equalTo(_shadeView).offset(30/3);
        make.height.equalTo(@13);
    }];
    [_labShopClass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shadeView).offset(33/3);
        make.right.equalTo(_shadeView).offset(-30/3);
    }];
    
    float starsOffSet = 2;
    [imgStarGray1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_labShopName.mas_bottom).offset(5);
        make.left.equalTo(_labShopName.mas_left);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    [imgStarGray2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgStarGray1.mas_right).offset(starsOffSet);
        make.top.equalTo(imgStarGray1);
        make.size.equalTo(imgStarGray1);
    }];
    [imgStarGray3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgStarGray2.mas_right).offset(starsOffSet);
        make.top.equalTo(imgStarGray1);
        make.size.equalTo(imgStarGray1);
    }];
    [imgStarGray4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgStarGray3.mas_right).offset(starsOffSet);
        make.top.equalTo(imgStarGray1);
        make.size.equalTo(imgStarGray1);
    }];
    [imgStarGray5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgStarGray4.mas_right).offset(starsOffSet);
        make.top.equalTo(imgStarGray1);
        make.size.equalTo(imgStarGray1);
    }];
    [_labScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imgStarGray5);
        make.left.equalTo(imgStarGray5.mas_right).offset(starsOffSet);
        make.width.equalTo(@30);
        make.height.equalTo(@10);
    }];
    [self._btnShopDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgView.mas_bottom).offset(34/3);
//        make.left.equalTo(self.contentView).offset(30);
        make.left.equalTo(@((self.contentView.frame.size.width-45)/6));
        make.width.equalTo(@(60/2.25));
        make.height.equalTo(@(60/2.25));
    }];
    [_labShopDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self._btnShopDetail.mas_bottom).offset(14/2/2);
        make.centerX.equalTo(self._btnShopDetail);
        make.width.equalTo(@80);
        make.height.equalTo(@15);
    }];
    [self._btnShopMap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self._btnShopDetail);
        make.centerX.equalTo(self.contentView);
        make.size.equalTo(self._btnShopDetail);
    }];
    [_labShopMap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_labShopDetail);
        make.centerX.equalTo(self._btnShopMap);
        make.size.equalTo(_labShopDetail);
    }];
    [self._btnCoupon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self._btnShopDetail);
//        make.right.equalTo(self.contentView).offset(-30);
        make.right.equalTo(self.contentView).offset(-(self.contentView.frame.size.width-45)/6);
        make.size.equalTo(self._btnShopDetail);
    }];
    [_labCoupon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_labShopDetail);
        make.centerX.equalTo(self._btnCoupon);
        make.size.equalTo(_labShopDetail);
    }];
    
    [_viewDescBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_labShopDetail.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    [_labDescription mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_viewDescBg).offset(6);
        make.height.equalTo(_viewDescBg).offset(-10);
        make.left.equalTo(_viewDescBg).offset(5);
        make.right.equalTo(_viewDescBg).offset(-5);
    }];
    
    [imageSplit1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgView.mas_bottom).offset(6);
        make.left.equalTo(self.contentView).offset(self.contentView.frame.size.width/3);
        make.bottom.equalTo(_viewDescBg.mas_top).offset(-4);
    }];
    [imageSplit2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageSplit1);
        make.right.equalTo(self.contentView).offset(-self.contentView.frame.size.width/3);
        make.height.equalTo(imageSplit1);
    }];
}
@end
