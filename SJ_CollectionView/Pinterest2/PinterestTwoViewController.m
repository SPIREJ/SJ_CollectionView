//
//  PinterestTwoViewController.m
//  SJ_CollectionView
//
//  Created by SPIREJ on 16/7/5.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "PinterestTwoViewController.h"
#import "WaterFallLayout.h"
#import "PhotosWallCell.h"

#define cellIdentify @"CELLIDENTIFY"

@interface PinterestTwoViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, WaterFallLayoutDelegate>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *photos;
@property (nonatomic, assign)NSUInteger currentPage; //当前页码
@end

@implementation PinterestTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"瀑布流篇II";
    self.view.backgroundColor = [UIColor whiteColor];
    self.currentPage = 0;
    [self photos];
    [self.view addSubview:self.collectionView];
    [self refreshAndLoading];
    //第一次进入自动刷新
    [self.collectionView.mj_header beginRefreshing];
}

- (NSMutableArray *)photos {
    if (_photos == nil) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        WaterFallLayout *waterFallLayout = [[WaterFallLayout alloc] init];
        waterFallLayout.delegate = self;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight) collectionViewLayout:waterFallLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        //xib的cell注册时必须用registerNib
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PhotosWallCell class]) bundle:nil] forCellWithReuseIdentifier:cellIdentify];
    }
    return _collectionView;
}

- (void)refreshAndLoading {
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //模拟网络延迟
            //清空数据
            if (self.photos.count > 0) {
                [self.photos removeAllObjects];
            }
            //新数据
            [self.photos addObjectsFromArray:[self newPhotos]];
            [self.collectionView reloadData];
            [self.collectionView.mj_header endRefreshing];
        });
    }];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //
            [self.photos addObjectsFromArray:[self loadMorePhotosWithCurrentPage:self.currentPage]];
            [self.collectionView reloadData];
            [self.collectionView.mj_footer endRefreshing];
        });
    }];
}

- (NSArray *)newPhotos {
    return [Photos mj_objectArrayWithFilename:@"0.plist"];
}

- (NSArray *)loadMorePhotosWithCurrentPage:(NSUInteger)currentPage {
    if (currentPage == 3) {
        self.currentPage = 0;
    }else {
        self.currentPage++;
    }
    NSString *nextPage = [NSString stringWithFormat:@"%lu.plist", self.currentPage];
    return [Photos mj_objectArrayWithFilename:nextPage];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotosWallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentify forIndexPath:indexPath];
    cell.photos = self.photos[indexPath.item];
    return cell;
}

#pragma mark - WaterFallLayoutDelegate
//返回每个items的高度
- (CGFloat)waterFallLayout:(WaterFallLayout *)waterFallLayout heightForItemAtIndex:(NSUInteger)index width:(CGFloat)width {
    Photos *photos = self.photos[index];
    CGFloat photoH = [photos.h doubleValue];
    CGFloat photoW = [photos.w doubleValue];
    return photoH * width / photoW;
}


//下面几个方法设置collectionView样式
//列数
- (NSUInteger)columnCountOfWaterFallLayout:(WaterFallLayout *)waterFallLayout {
    return 2;
}
//行间距
- (CGFloat)rowMarginOfWaterFallLayout:(WaterFallLayout *)waterFallLayout {
    return 10;
}
//列间距
- (CGFloat)columnMarginOfWaterFallLayout:(WaterFallLayout *)waterFallLayout {
    return 10;
}
//collectionView内边距
- (UIEdgeInsets)edgeInsetsOfWaterFallLayout:(WaterFallLayout *)waterFallLayout {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


@end
