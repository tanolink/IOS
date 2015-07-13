//
//  CTCBar.m
//  BadgeBtnTest
//
//  Created by aokuny on 14/10/27.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "CTCBar.h"
@interface CTCBar ()


@property (nonatomic, copy) void (^block)(NSUInteger index);
@property (nonatomic, assign) BOOL bSepra;

@end

@implementation CTCBar

-(id)initWithFrame:(CGRect)frame andArrData:(NSArray *)arrData bSpera:(BOOL)bSepra andBlock:(void (^)(NSUInteger idx))block {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.block = block;
        float nHeight = self.frame.size.height;
        _bSepra =bSepra;
        NSUInteger _nSumOfLine = arrData.count;
        float nWidth = self.frame.size.width / (_nSumOfLine*1.f);
        
        [arrData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (idx==2) {
                *stop = YES;
                return ;
            }
            NSArray *itemArr = (NSArray *)obj;
            NSString *title = itemArr[0];
            NSString *imgStr = itemArr[1];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:title forState:UIControlStateNormal];
            
            [btn setTitleColor:RGBCOLOR(102,102,102) forState:UIControlStateNormal];
            [btn setTitleColor:RGBCOLOR(254,130,0) forState:UIControlStateSelected];
            [btn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"tab_arrow2"] forState:UIControlStateSelected];
            btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
            
            btn.frame = CGRectMake(idx * nWidth, 0, nWidth, nHeight);
//            btn.tag = idx;
            btn.tag = idx+1000;

            [btn addTarget:self action:@selector(ddd:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,20)];
            btn.imageEdgeInsets = UIEdgeInsetsMake(2,60,0,0);
            btn.titleLabel.font = DEFAULT_FONT(13);
            
            if (_bSepra && idx < _nSumOfLine-1) {
                CGRect frame = btn.frame;
                frame.size.width = 1;
                frame.origin.x = CGRectGetMaxX(btn.frame) - frame.size.width;
                UIImageView *lineV = [[UIImageView alloc]initWithFrame:frame];
                lineV.image = [UIImage imageNamed:@"split"];
                lineV.backgroundColor = [UIColor clearColor];
                [self addSubview:lineV];
            }
        }];
        UIView *lineView;
        lineView = [[UIView alloc] init];
        lineView.backgroundColor = RGBCOLOR(230,230,230);
        [lineView setFrame:CGRectMake(0,frame.size.height-1,frame.size.width,1)];
        [self addSubview:lineView];
    }
    return self;
}
-(void)ddd:(UIButton *)btn {
    
//    NSLog(@" tag : %li",(long)btn.tag);
////    if (btn.tag == 1) {
////        btn.selected = !btn.selected;
////    }
//    
//    btn.selected = !btn.selected;
//
//    
//    if (self.block) {
//        self.block(btn.tag);
//    }
    
//    btn.selected = YES;
        btn.selected = !btn.selected;

    NSLog(@" tag : %li",(long)btn.tag);
    if (btn.tag == 1001) {
        UIButton *btnOther = (UIButton *)[self viewWithTag:1000];
        btnOther.selected = NO;
    }else{
        UIButton *btnOther = (UIButton *)[self viewWithTag:1001];
        btnOther.selected = NO;
    }
    if (self.block) {
        self.block(btn.tag);
    }
    
}
@end
