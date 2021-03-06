//
//  MainViewController.m
//  SJ_CollectionView
//
//  Created by SPIREJ on 16/6/30.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "MainViewController.h"
#import "BasciCollectionViewController.h"
#import "PinterestViewController.h"
#import "PinterestTwoViewController.h"
#define cellHeight 70

#define kLabelTitles @[@"1- UICollectionView基础篇", @"2- 瀑布流", @"3- 瀑布流II"]
#define kDetialLabelText @[@"BasciCollectionViewController", @"PinterestViewController", @"PinterestTwoViewController"]

@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, copy)NSMutableArray *labelTextArray;
@property(nonatomic, copy)NSMutableArray *DetailLabelTextArray;

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"主页";
    
    [self labelTextArray];
    [self DetailLabelTextArray];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
    }
    return _tableView;
}
- (NSMutableArray *)labelTextArray{
    if (!_labelTextArray) {
        _labelTextArray = [NSMutableArray arrayWithArray:kLabelTitles];
    }
    return _labelTextArray;
}
- (NSMutableArray *)DetailLabelTextArray{
    if (!_DetailLabelTextArray) {
        _DetailLabelTextArray = [NSMutableArray arrayWithArray:kDetialLabelText];
    }
    return _DetailLabelTextArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _labelTextArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifily = @"cellIdentifily";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifily];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifily];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = _labelTextArray[indexPath.row];
    cell.detailTextLabel.text = _DetailLabelTextArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            BasciCollectionViewController *basciCollectionVC = [[BasciCollectionViewController alloc] init];
            [self.navigationController pushViewController:basciCollectionVC animated:YES];
        }
            break;
        case 1:{
            PinterestViewController *pinterestVC = [[PinterestViewController alloc] init];
            [self.navigationController pushViewController:pinterestVC animated:YES];
        }
            break;
        case 2:{
            PinterestTwoViewController *pinterestTwoVC = [[PinterestTwoViewController alloc] init];
            [self.navigationController pushViewController:pinterestTwoVC animated:YES];
        }
            break;

        default:
            break;
    }
}
@end
