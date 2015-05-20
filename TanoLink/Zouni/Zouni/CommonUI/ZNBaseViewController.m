//
//  ZNBaseViewController.m
//  Zouni
//
//  Created by Aokuny on 14-9-16.
//  Copyright (c) 2015年 Zouni. All rights reserved.
//

#import "ZNBaseViewController.h"
#import "ZNAppUtil.h"
#import "MJRefresh.h"
@interface ZNBaseViewController ()

@end

@implementation ZNBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (UIButton *)buttonWithTitle:(NSString*)aTitle image:(UIImage*)image highligted:(UIImage*)highligteImage target:(id)target action:(SEL)action
{
    UIFont * font=DEFAULT_FONT(16);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize size = [aTitle sizeWithFont:font constrainedToSize:CGSizeMake(ScreenWidth, 30)];
    CGRect rect = CGRectMake(0, 0, size.width, 30);
    if (image) {
        rect = CGRectMake(0, 0, MIN(22.f,  image.size.width)/*25.f*/, MIN( image.size.height,22.f )/*25.f*/);
    }
    button.frame = rect;
    [button setTitle:aTitle forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button setTitleColor:[UIColor colorWithWhite:1.000 alpha:1.000] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.953 green:0.948 blue:0.959 alpha:1.000] forState:UIControlStateHighlighted];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:highligteImage forState:UIControlStateHighlighted];
    button.imageView.contentMode = UIViewContentModeScaleToFill;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    /*[button setShowsTouchWhenHighlighted:YES];*/
    return button;
}

- (void)setRightBarSystemButtonItemTitle:(NSString *)aTitle target:(id)target action:(SEL)action {

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:aTitle style:UIBarButtonItemStylePlain target:target action:action];
}

- (void)setRightBarButtonItemTitle:(NSString *)aTitle target:(id)target action:(SEL)action
{
    [self setRightBarSystemButtonItemTitle:aTitle target:target action:action];
    
    /*UIButton *button = [self buttonWithTitle:aTitle image:nil highligted:nil target:target action:action];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];*/
}

- (void)setRightBarButtonItemImage:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *button = [self buttonWithTitle:nil image:[UIImage imageNamed:imageName] highligted:nil target:target action:action];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)setBackBarButtonItemTitle:(NSString *)aTitle target:(id)target action:(SEL)action
{
    UIButton *button = [self buttonWithTitle:aTitle image:nil highligted:nil target:target action:action];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)setBackBarButtonItemImage:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *button = [self buttonWithTitle:nil image:[UIImage imageNamed:imageName] highligted:nil target:target action:action];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)setNavTitle:(NSString *)title titleColor:(UIColor *)titleColor {
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-150/2, 0,150, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = titleColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    UIFont * font=DEFAULT_FONT(18);
    [titleLabel setFont:font];
    [titleLabel setText:title];
    self.navigationItem.titleView = titleLabel;
}

-(void)setNavTitle:(NSString *)title {
    [self setNavTitle:title titleColor:[UIColor blackColor]];
}

-(void)setLogBackBarButton:(NSString *)imgStr target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat width= -15;
    if ([UIImage imageNamed:imgStr].size.width>20.f) {
        btn.frame =CGRectMake(0,0, 120, 36);
    } else {
        btn.frame =CGRectMake(0,0, 20, 36);
        width = -18;
    }
    
    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    if ( JRSystemVersionGreaterOrEqualThan(7.0)) {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = width;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, buttonItem];
    }else{
        self.navigationItem.leftBarButtonItem = buttonItem;
    }
}

-(void)setLogBackBarButton{
    [self setLogBackBarButton:NO];
}

-(void)setLogBackBarButton:(BOOL)isNeedSender{
    if (!isNeedSender) {
        [self setLogBackBarButton:@"navbar_leftbtn_logo" target:self action:@selector(goLogoBack)];
    }else{
        [self setLogBackBarButton:@"navbar_leftbtn_logo" target:self action:@selector(goLogoBack:)];
    }
}

-(void)setNoLogBackBarButton {
    [self setLogBackBarButton:@"navbar_leftbtn_menu" target:self action:@selector(goLogoBack)];
}

- (void)setBackBarButton {
    /*UIButton *button = [self buttonWithTitle:nil image:[UIImage createBackArrowImage] highligted:nil target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];*/
    
    [self setBackBarButtonItemImage:@"arrow_back" target:self action:@selector(goBack)];
    
}

/*子类重写*/
-(void)goLogoBack {
  
}
/*子类重写*/
-(void)goLogoBack:(id)sender {
    
}
-(void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightAction {

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    self.view.backgroundColor = [UIColor colorWithRed:207 / 255.0 green:210 /255.0 blue:213 / 255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupRefreshForTableView:(UITableView *)tableView {

 /*1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
 dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间*/
    
    [tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    
    /*#warning 自动刷新(一进入程序就下拉刷新)*/
    /*[tableView headerBeginRefreshing];*/
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    tableView.headerPullToRefreshText = @"下拉刷新";
    tableView.headerReleaseToRefreshText = @"松开刷新";
    tableView.headerRefreshingText = @"加载中...";
    
    tableView.footerPullToRefreshText = @"上拉刷新";
    tableView.footerReleaseToRefreshText = @"松开刷新";
    tableView.footerRefreshingText = @"加载中...";
}
-(void)setupRefreshForCollectionView:(UICollectionView *)collectionView {
    
    /*1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
     [tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
     dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间*/
    
    [collectionView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"table"];
    
    /*#warning 自动刷新(一进入程序就下拉刷新)*/
    /*[tableView headerBeginRefreshing];*/
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [collectionView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    collectionView.headerPullToRefreshText = @"下拉刷新";
    collectionView.headerReleaseToRefreshText = @"松开刷新";
    collectionView.headerRefreshingText = @"加载中...";
    
    collectionView.footerPullToRefreshText = @"上拉刷新";
    collectionView.footerReleaseToRefreshText = @"松开刷新";
    collectionView.footerRefreshingText = @"加载中...";
}
/*子类继承*/
-(void) headerRereshing {

}

-(void) footerRereshing {

}

@end
