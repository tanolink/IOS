//
//  CellCommentTableViewCell.m
//  Zouni
//
//  Created by aokuny on 15/6/25.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "CellCommentTableViewCell.h"
#import "ZNAppUtil.h"

@implementation CellCommentTableViewCell{}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _labUserName = [[UILabel alloc]initWithFrame:CGRectZero];
        [_labUserName setFont:DEFAULT_BOLD_FONT(13)];
        [_labUserName setNumberOfLines:0];
        [_labUserName setTextColor:[UIColor whiteColor]];
        [_labUserName setLineBreakMode:NSLineBreakByTruncatingTail];
        
        [_labUserName setText:@"useranme"];
        
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:_labUserName];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_labUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(18);
        make.left.equalTo(self.contentView).offset(30/2);
    }];
}



- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end