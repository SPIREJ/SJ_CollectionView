//
//  PinterestViewController.m
//  SJ_CollectionView
//
//  Created by SPIREJ on 16/7/1.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "PinterestViewController.h"
#import "WaterLayout.h"


@interface PinterestViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UICollectionView *collectionView;
@end

@implementation PinterestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"瀑布流";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
}


- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        WaterLayout *waterLayter = [[WaterLayout alloc] initWithLineNumber:3 rowSpace:10 lineSpace:10 sectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
        [waterLayter computeIndexCellHeightWithWidthBlock:^CGFloat(NSIndexPath *indexPath, CGFloat width) {
            //这里采用随机数模拟 传入item的高为80~180之间随机
            return  (80 + arc4random()%100 + 1);
        }];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight) collectionViewLayout:waterLayter];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"IDENTIFY"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 99;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IDENTIFY" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}


@end
