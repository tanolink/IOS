//
//  ShopDetailViewController.m
//  Zouni
//
//  Created by aokuny on 15/5/17.
//  Copyright (c) 2015年 TanoLink. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "ZNAppUtil.h"
#import "UMSocial.h"
#import "ShopCommentViewController.h"
#import "CellCommentTableViewCell.h"

@interface ShopDetailViewController (){
    /**
     * 显示表格控件
     */
    UITableView *_gTableView;
    
    NSArray *networkCaptions;
    NSMutableArray *networkImages;
    FGalleryViewController *localGallery;
    FGalleryViewController *networkGallery;
    
    CommentModel *commentModel;
    
    NSMutableArray *_dataMutableArrayListComment;
}
@end
@implementation ShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setBackBarButton];
    
    [self setTitle:@"店铺详情"];
    [self setRightBarButtonItemTitle:@"分享" target:self action:@selector(share)];
//    [self setRightBarButtonItemImage:@"share_icon" target:self action:@selector(share)];

    [self showHudInView:self.view hint:nil];
    __weak typeof(self) weakSelf = self;
    NSDictionary *requestDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                self.shopModel.ShopID,@"shopId",
                                @"2",@"comments",
                                nil];
    // 获取详情评论
    [ZNApi invokePost:ZN_SHOPDETAIL_API parameters:requestDic completion:^(id resultObj,NSString *msg,ZNRespModel *respModel) {
        if (resultObj) {
            NSDictionary *shopModelDic = (NSDictionary *)resultObj;
            self.shopModel.FavoriteStatus = shopModelDic[@"FavoriteStatus"];
            _dataMutableArrayListComment = [[NSMutableArray alloc]initWithArray:shopModelDic[@"Comments"]];
            _gTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
            [_gTableView setDelegate:self];
            [_gTableView setDataSource:self];
            [_gTableView setTableFooterView:[[UIView alloc]init]];
            [_gTableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
            if([_gTableView respondsToSelector:@selector(setSeparatorInset:)]){
                [_gTableView setSeparatorInset:UIEdgeInsetsZero];
            }
            [self.view addSubview:_gTableView];
        }
        [weakSelf hideHud];
    }];
}
-(void) share{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMengAppKey
                                      shareText:@"走你app是您在日本的私人贴身导游，美食购物优惠券让您随时享用。"
                                     shareImage:[UIImage imageNamed:@"Icon"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,
                                                 UMShareToQzone,UMShareToWechatTimeline,UMShareToEmail,nil]
                                       delegate:self];
}
#pragma mark tableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Indentifier = @"cellInd";
    CellShopDetail *cell = [tableView dequeueReusableCellWithIdentifier:Indentifier];
    if (!cell) {
        cell = [[CellShopDetail alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indentifier];
            cell.shopID = [NSString stringWithFormat:@"%@",self.shopId];
    }
    cell.shopModel = self.shopModel;
    cell._dataMutableArray = _dataMutableArrayListComment;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [cell._btnAlbum addTarget:self action:@selector(detail) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnShowComment addTarget:self action:@selector(comments) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
#pragma mark - tableview delegate methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    CellShopDetail *cell = (CellShopDetail*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    float commentHeight = 0;
    for (NSDictionary *commnetDic in _dataMutableArrayListComment) {
        NSError *err = nil;
        CommentModel *cm = [[CommentModel alloc]initWithDictionary:commnetDic error:&err];
        commentHeight += (float)[CellCommentTableViewCell getCellHeightForModel:cm];
    }
    CGSize contentHeight = [self.shopModel.desc sizeWithFont:DEFAULT_FONT(12) constrainedToSize:CGSizeMake(ScreenWidth-30,MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    if(self.shopModel.desc.length>0){
        commentHeight += (contentHeight.height -15);
    }
    return commentHeight + 800;
}
-(void) comments {
    ShopCommentViewController *scvc = [ShopCommentViewController new];
    scvc.shopId = self.shopModel.ShopID;
    [self.navigationController pushViewController:scvc animated:YES];
}
-(void) detail{
    
    // 店铺图片信息
    networkImages = [NSMutableArray arrayWithArray:self.shopModel.Images];
    networkGallery = [[FGalleryViewController alloc] initWithPhotoSource:self];
    [self.navigationController pushViewController:networkGallery animated:YES];
}

#pragma mark - Gallery

#pragma mark - FGalleryViewControllerDelegate Methods

- (int)numberOfPhotosForPhotoGallery:(FGalleryViewController *)gallery
{
    int num;
    if( gallery == localGallery ) {
        //num = [localImages count];
    }
    else if( gallery == networkGallery ) {
        num = (int)[networkImages count];
    }
    return num;
}
- (FGalleryPhotoSourceType)photoGallery:(FGalleryViewController *)gallery sourceTypeForPhotoAtIndex:(NSUInteger)index
{
    //    if( gallery == localGallery ) {
    //        return FGalleryPhotoSourceTypeLocal;
    //    }
    //    else {
    return FGalleryPhotoSourceTypeNetwork;
    //    }
}
- (NSString*)photoGallery:(FGalleryViewController *)gallery captionForPhotoAtIndex:(NSUInteger)index
{
    NSString *caption;
    if( gallery == localGallery ) {
        //caption = [localCaptions objectAtIndex:index];
    }
    else if( gallery == networkGallery ) {
//         caption = [networkCaptions objectAtIndex:index];
        caption = self.shopModel.ShopName;
    }
    return caption;
}

//- (NSString*)photoGallery:(FGalleryViewController*)gallery filePathForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index {
//    return [localImages objectAtIndex:index];
//}

- (NSString*)photoGallery:(FGalleryViewController *)gallery urlForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index {
    return  [networkImages objectAtIndex:index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
