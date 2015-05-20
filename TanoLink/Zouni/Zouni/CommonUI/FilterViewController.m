//
//  FilterViewController.m
//
//  Created by aokuny on 14/10/28.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "FilterViewController.h"
#import "ZNAppUtil.h"
@interface FilterViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation FilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"筛选" titleColor:[UIColor blackColor]];
    [self setRightBarButtonItemTitle:@"取消" target:self  action:@selector(dimiss)];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _tableView.backgroundColor = [UIColor colorWithWhite:0.929 alpha:1.000];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 51+15, 0);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.106 green:0.306 blue:0.627 alpha:1.000]] forState:UIControlStateNormal];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [self.view addSubview:_tableView];
    btn.frame = CGRectMake(0, 0, 65, 40);
    [btn addTarget:self action:@selector(choiceAction) forControlEvents:UIControlEventTouchUpInside];
    /*UIView *toolbarView =  [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-51-64, self.view.frame.size.width, 51)];
     toolbarView.backgroundColor = [UIColor whiteColor];
     CGRect frame = btn.frame;
     frame.origin.x = toolbarView.frame.size.width - 20 - frame.size.width;
     frame.origin.y = (toolbarView.frame.size.height - frame.size.height ) /2.f;
     btn.frame = frame;
     [toolbarView addSubview:btn];
     [self.view addSubview:toolbarView];*/
    UIToolbar *toolbar  = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-51-64, self.view.frame.size.width, 51)];
    [toolbar setBarStyle:UIBarStyleDefault];
    [toolbar setBarTintColor:[UIColor whiteColor]];
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithCustomView:btn];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *space2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space2.width = 1;
    toolbar.items = @[space,bbi,space2];
    [self.view addSubview:toolbar];

    if (!self.chocieDic) {
        self.chocieDic =[NSMutableDictionary dictionary];
        for (NSDictionary *dic in self.dataArr) {
            NSDictionary *groupDic = dic[@"group"];
            self.chocieDic[groupDic[@"v"]] = kNULLROWV;
        }
    }
}


-(NSString *)makeKeyGroupV:(NSString *)groupV rowV:(NSString *)rowV {
    return [groupV stringByAppendingString:rowV];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dimiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)choiceAction {

    if ([self.delegate respondsToSelector:@selector(filterViewClose:)]) {
        [self.delegate filterViewClose:self.chocieDic];
    }
    [self dimiss];
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSDictionary *dataDic = [self.dataArr objectAtIndex:section];
    NSArray *rows = dataDic[@"rows"];
    return rows.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    NSDictionary *dataDic = [self.dataArr objectAtIndex:indexPath.section];
    NSArray *rows = dataDic[@"rows"];
    NSDictionary *rowDic = rows[indexPath.row];
    NSDictionary *groupDic = dataDic[@"group"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", rowDic[@"k"]];
    if ([self.chocieDic[groupDic[@"v"] ] isEqualToString:rowDic[@"v"]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.font = DEFAULT_FONT(14);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.tableView.frame.size.width, 33)];
    label.backgroundColor = [UIColor clearColor];
    NSDictionary *dataDic = [self.dataArr objectAtIndex:section];
    NSDictionary *groupDic = dataDic[@"group"];
    label.font = DEFAULT_FONT(14);
    [label setText:groupDic[@"k"]];
    [contentView addSubview:label];
    return contentView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 33;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dataDic = self.dataArr[indexPath.section];
    NSDictionary *groupDic = dataDic[@"group"];
    
    NSArray *rowsArr = dataDic[@"rows"];
    NSDictionary *rowDic = rowsArr[indexPath.row];
    NSString *rowV = rowDic[@"v"];
    
    if ([self.chocieDic[groupDic[@"v"]] isEqualToString: rowV]) {
        self.chocieDic[groupDic[@"v"]] = kNULLROWV;
    } else {
        self.chocieDic[groupDic[@"v"]] = rowV;
    }
    [self.tableView reloadData];
    
}

@end
