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

@interface ShopDetailViewController (){
    /**
     * 显示表格控件
     */
    UITableView *_gTableView;
    
    NSArray *networkCaptions;
    NSMutableArray *networkImages;
    FGalleryViewController *localGallery;
    FGalleryViewController *networkGallery;

}
@end
@implementation ShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setBackBarButton];
//    [self setRightBarButtonItemImage:@"share_icon" target:self action:@selector(share)];
    
//    UIBarButtonItem *btnAction = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
//    self.navigationController.navigationItem.rightBarButtonItem = btnAction;
    
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
-(void) share{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"556885e767e58e40ca001421"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,
                                                 UMShareToQzone,UMShareToWechatTimeline,UMShareToEmail,nil]
                                       delegate:nil];
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
//        [cell setCellDataForModel:self.shopModel];
    }
    cell.shopModel = self.shopModel;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [cell._btnAlbum addTarget:self action:@selector(detail) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnShowComment addTarget:self action:@selector(comments) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
#pragma mark - tableview delegate methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 700.00f;
}
-(void) comments {
    ShopCommentViewController *scvc = [ShopCommentViewController new];
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
