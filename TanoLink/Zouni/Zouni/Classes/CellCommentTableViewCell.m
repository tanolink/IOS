//
//  CellCommentTableViewCell.m
//  Zouni
//
//  Created by aokuny on 15/6/25.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "CellCommentTableViewCell.h"
#import "ZNAppUtil.h"
#import "UIButton+WebCache.h"

@implementation CellCommentTableViewCell{
    UIButton *btnUserHead;
    UILabel *labComment;
    //  星星
    UIImageView *imgStarGray1;
    UIImageView *imgStarGray2;
    UIImageView *imgStarGray3;
    UIImageView *imgStarGray4;
    UIImageView *imgStarGray5;
    NSMutableArray *_mutArrayStars;
    
    UIButton *btnImg1;
    UIButton *btnImg2;
    UIButton *btnImg3;
    UIButton *btnImg4;
    NSArray *_mutArray;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        btnUserHead = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnUserHead setUserInteractionEnabled:NO];
        btnUserHead.layer.cornerRadius = 13;
        btnUserHead.layer.masksToBounds = YES;
//        btnUserHead.layer.borderWidth = 1.f;
        btnUserHead.layer.borderColor = [[UIColor colorWithWhite:1.000 alpha:0.800]CGColor];
//        [btnUserHead setImage:[UIImage imageNamed:@"default_avatar"] forState:UIControlStateNormal];

        _labUserName = [[UILabel alloc]initWithFrame:CGRectZero];
        [_labUserName setFont:DEFAULT_BOLD_FONT(13)];
        [_labUserName setNumberOfLines:0];
        [_labUserName setTextColor:[UIColor blackColor]];
        [_labUserName setLineBreakMode:NSLineBreakByTruncatingTail];
        
        labComment = [[UILabel alloc]initWithFrame:CGRectZero];
        [labComment setFont:DEFAULT_FONT(12)];
        [labComment setNumberOfLines:0];
        [labComment setTextColor:ZN_FONNT_02_GRAY];
        [labComment setLineBreakMode:NSLineBreakByTruncatingTail];
        
        imgStarGray1 = [[UIImageView alloc]initWithFrame:CGRectZero];
        [imgStarGray1 setImage:[UIImage imageNamed:@"xing01"]];
        [self.contentView addSubview:imgStarGray1];
        imgStarGray2 = [[UIImageView alloc]initWithFrame:CGRectZero];
        [imgStarGray2 setImage:[UIImage imageNamed:@"xing01"]];
        [self.contentView addSubview:imgStarGray2];
        imgStarGray3 = [[UIImageView alloc]initWithFrame:CGRectZero];
        [imgStarGray3 setImage:[UIImage imageNamed:@"xing01"]];
        [self.contentView addSubview:imgStarGray3];
        imgStarGray4 = [[UIImageView alloc]initWithFrame:CGRectZero];
        [imgStarGray4 setImage:[UIImage imageNamed:@"xing01"]];
        [self.contentView addSubview:imgStarGray4];
        imgStarGray5 = [[UIImageView alloc]initWithFrame:CGRectZero];
        [imgStarGray5 setImage:[UIImage imageNamed:@"xing01"]];
        _mutArrayStars = [NSMutableArray arrayWithArray:@[imgStarGray1,imgStarGray2,imgStarGray3,imgStarGray4,imgStarGray5]];

        [self.contentView addSubview:imgStarGray1];
        [self.contentView addSubview:imgStarGray2];
        [self.contentView addSubview:imgStarGray3];
        [self.contentView addSubview:imgStarGray4];
        [self.contentView addSubview:imgStarGray5];
        
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:_labUserName];
        
        btnImg1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnImg1 setUserInteractionEnabled:NO];
        btnImg2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnImg2 setUserInteractionEnabled:NO];
        btnImg3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnImg3 setUserInteractionEnabled:NO];
        btnImg4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnImg4 setUserInteractionEnabled:NO];
        
//        
//        [btnImg1 setImage:[UIImage imageNamed:@"default_avatar"] forState:UIControlStateNormal];
//        [btnImg2 setImage:[UIImage imageNamed:@"default_avatar"] forState:UIControlStateNormal];
//        [btnImg3 setImage:[UIImage imageNamed:@"default_avatar"] forState:UIControlStateNormal];
//        [btnImg4 setImage:[UIImage imageNamed:@"default_avatar"] forState:UIControlStateNormal];
        
        _mutArray = @[btnImg1,btnImg2,btnImg3,btnImg4];

        [self.contentView addSubview:btnImg1];
        [self.contentView addSubview:btnImg2];
        [self.contentView addSubview:btnImg3];
        [self.contentView addSubview:btnImg4];
        
        [self.contentView addSubview:btnUserHead];
        [self.contentView addSubview:labComment];

    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [btnUserHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    [_labUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnUserHead.mas_top).offset(4);
//        make.centerY.equalTo(btnUserHead.mas_centerY);
        make.left.equalTo(btnUserHead.mas_right).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@15);
    }];
    float starsOffSet = 2;
    [imgStarGray1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_labUserName.mas_bottom).offset(5);
        make.left.equalTo(_labUserName.mas_left);
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

    [labComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnUserHead.mas_bottom).offset(5);
        make.left.equalTo(btnUserHead);
        make.width.equalTo(@(self.contentView.frame.size.width-30));
//        make.height.equalTo(@13);
    }];
    float offset = 2;
    [btnImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labComment.mas_bottom).offset(10);
        make.left.equalTo(btnUserHead.mas_left);
        make.width.equalTo(@[btnImg2,btnImg3,btnImg4,@70]);
        make.height.equalTo(@[btnImg2,btnImg3,btnImg4,@70]);
    }];
    [btnImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnImg1.mas_right).offset(offset);
        make.top.equalTo(btnImg1.mas_top);
//        make.right.equalTo(btnImg3.mas_left);
    }];
    [btnImg3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnImg2.mas_right).offset(offset);
//        make.right.equalTo(btnImg4.mas_left);
        make.top.equalTo(btnImg1.mas_top);
    }];
    [btnImg4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnImg3.mas_right).offset(offset);
        make.top.equalTo(btnImg1.mas_top);
    }];
    
}
-(void) setCellDataForModel:(CommentModel *) commentModel {
    [_labUserName setText:commentModel.UserName];
    [labComment setText:commentModel.Content];
    NSString *imageUrl = commentModel.userPhoto;
    NSURL *caseurl = [NSURL URLWithString:imageUrl];
    [btnUserHead sd_setBackgroundImageWithURL:caseurl forState:UIControlStateNormal
                          placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    //处理星星
    for (int i=0 ; i< commentModel.Score.integerValue ;i++) {
        UIImageView *imgV = (UIImageView*)_mutArrayStars[i];
        [imgV setImage:[UIImage imageNamed:@"xing02"]];
    }
    NSUInteger count = commentModel.Images.count;
    count = 4;
    for (int i=0;i<count;i++) {
        UIButton *Img = (UIButton *)_mutArray[i];
        if(i<commentModel.Images.count){
            NSLog(@"%lul",(unsigned long)commentModel.Images.count);
            NSString *imageUrl = commentModel.Images[i];
            NSURL *caseurl = [NSURL URLWithString:imageUrl];
            [Img sd_setBackgroundImageWithURL:caseurl forState:UIControlStateNormal
                                     placeholderImage:[UIImage imageNamed:@"default_avatar"]];
        }else{
            [Img setFrame:CGRectZero];
            Img = nil;
        }
    }
}
+(float)getCellHeightForModel:(CommentModel *) commentModel{
    ///总高度
    float totalHeight = 90;
    CGSize contentHeight = [commentModel.Content sizeWithFont:DEFAULT_FONT(12) constrainedToSize:CGSizeMake(ScreenWidth-30,MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    if (contentHeight.height > 15) {
        totalHeight += contentHeight.height - 15;
    }
    if(commentModel.Images.count>0){
        totalHeight += 75;
    }
    return totalHeight;
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end