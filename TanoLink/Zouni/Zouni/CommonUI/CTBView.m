//
//  CTBView.m
//  Created by aokuny on 14/10/28.
//  Copyright (c) 2014年. All rights reserved.
//

#import "CTBView.h"

@interface CTBView() <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIControl* dimView;
@property (nonatomic, strong) UIControl* bgView;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, assign) CGFloat offSetY;
@property (nonatomic, assign) BOOL show;
@property (nonatomic, strong) NSMutableDictionary *defaultSelStr;
@end

@implementation CTBView

- (id)initWithArrData:(NSArray*)arrData andOffSetY:(CGFloat)offSetY delegate:(id<CTBViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.arrData = arrData;
        self.offSetY = offSetY;
        self.delegate = delegate;
        self.backgroundColor = [UIColor clearColor];
        self.show = NO;
    }
    
    return self;
}

+(CTBView*)showWindowWithArrData:(NSArray*)arraData insideView:(UIView*)view offSetY:(CGFloat)offSetY  delegate:(id<CTBViewDelegate>)delegate{
    
    CTBView* popup = [[CTBView alloc] initWithArrData:arraData andOffSetY:offSetY delegate:delegate];
    
    [popup showInView: view];
    
    return popup;
}

-(void)showInView:(UIView *)v andDefaultSel:(NSMutableDictionary *)defaultSelV {
    self.defaultSelStr = defaultSelV;
    [self showInView:v];
}

-(void)showInView:(UIView*)v
{
    if (self.show) {
//        [self closePopupWindow];
        [self closePopupWindowNotBack];
        return;
    }
    self.show = YES;
    CGRect frame = v.bounds;
    frame.origin.y = self.offSetY;
    _dimView = [[UIControl alloc] initWithFrame:frame];
    [_dimView addTarget:self action:@selector(closePopupWindow) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview: _dimView];
    
    self.backgroundColor = [UIColor clearColor];
    frame.origin.y = 0;
    frame.size.height = MIN( _arrData.count * 44.f, v.frame.size.height - _offSetY - 51);
    _tableView = [[UITableView alloc]initWithFrame:frame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.scrollEnabled = NO;
    frame.size.height = 1;
    self.frame = frame;
    [self addSubview:_tableView];
    [self performSelector:@selector(animatePopup:) withObject:v afterDelay:0.01];
    self.clipsToBounds = YES;
    if (!self.defaultSelStr) {
        self.defaultSelStr =[NSMutableDictionary dictionary];
        for (NSDictionary *dic in self.arrData) {
            self.defaultSelStr[dic[@"v"]] = kNULLROWV;
        }
    }
}

-(void)animatePopup:(UIView*)v
{
    [_dimView addSubview:self];
    
    [UIView animateWithDuration:.4 animations:^{
        _dimView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        CGRect frame = self.frame;
        frame.size.height = _tableView.frame.size.height;
        self.frame =frame;
    } completion: nil];
}

-(void)closePopupWindowNotBack
{
    [UIView animateWithDuration:.1 animations:^{
        _dimView.backgroundColor = [UIColor clearColor];
        CGRect frame = self.frame;
        frame.size.height =  0;
        self.frame =frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_dimView removeFromSuperview];
        _dimView = nil;
        self.show = NO;
    }];
}

-(void)closePopupWindow
{
    [self closePopupWindowIndexPath:nil];
}

-(void)closePopupWindowIndexPath:(NSIndexPath *)indexPath
{
    [UIView animateWithDuration:.1 animations:^{
        _dimView.backgroundColor = [UIColor clearColor];
        CGRect frame = self.frame;
        frame.size.height =  0;
        self.frame =frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_dimView removeFromSuperview];
        _dimView = nil;
        self.show = NO;
        // 回调
        if ([_delegate respondsToSelector:@selector(ctbChocie: withCTB:)]){
                [_delegate ctbChocie:self.defaultSelStr withCTB:self];
        }
    }];
    
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.arrData[indexPath.row][@"k"]];
    [cell.textLabel setTextColor:RGBCOLOR(102,102,102)];
    cell.textLabel.font = DEFAULT_FONT(12);

     NSString *key = self.arrData[indexPath.row][@"v"];
    if ([self.arrData[indexPath.row][@"v"] isEqualToString:self.defaultSelStr[key]]) {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        UIImage *imgCheckmark =[UIImage imageNamed:@"filter_select"];
        cell.accessoryView = nil;
        UIImageView *imgView = [[UIImageView alloc]initWithImage:imgCheckmark];
        [imgView setFrame:CGRectMake(0.0,0.0,34/2,34/2)];
        cell.accessoryView =imgView;
        [cell.textLabel setTextColor:RGBCOLOR(254,130,0)];
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryView = nil;
    }
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *key = self.arrData[indexPath.row][@"v"];
    if ([self.defaultSelStr[key] isEqualToString: key]) {
        self.defaultSelStr[key] = kNULLROWV;
    } else {
        if (self.isSingle) {
            for (NSDictionary *dic in self.arrData) {
//                if (![self.defaultSelStr[key] isEqualToString: key]) {
                    self.defaultSelStr[dic[@"v"]] = kNULLROWV;
//                }
            }
        }
        self.defaultSelStr[key] = self.arrData[indexPath.row][@"v"];
    }
    /*
    if (self.isSingle) {
        for (NSDictionary *dic in self.arrData) {
            if (![self.defaultSelStr[key] isEqualToString: key]) {
                self.defaultSelStr[dic[@"v"]] = kNULLROWV;
            }
        }
//        NSString *key = self.arrData[indexPath.row][@"v"];
//        self.defaultSelStr[key] = self.arrData[indexPath.row][@"v"];
        //        NSString *key = self.arrData[indexPath.row][@"v"];
        //        self.defaultSelStr[key] = self.arrData[indexPath.row][@"v"];
        //        NSLog(@"single:%@",self.defaultSelStr[key]);
        //        [self closePopupWindowIndexPath:indexPath];
    }*/
    [self.tableView reloadData];
//    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
@end
