//
//  BasciCollectionViewController.m
//  SJ_CollectionView
//
//  Created by SPIREJ on 16/7/1.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "BasciCollectionViewController.h"
#import "HeaderView.h"

#define kCollectionCellIdentify   @"kCollectionCellIdentify"

@interface BasciCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UICollectionView *basicCollectionView;
@end

@implementation BasciCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"基础篇";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.basicCollectionView];
}

- (UICollectionView *)basicCollectionView {
    if (_basicCollectionView == nil) {
        /*
         最简单的UICollectionFlowLayout效果,把一个个的Cell从左到右排,如果右边到屏幕头了,放不下了就跑到下一行继续从左到右排列一个个Cell,collectionview会根据你有没有设置minimumInteritemSpacing来设置你的每个cell的最小间距,和minimumLineSpacing来设置一行和一行的最小间距.
         */
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //全局设置，若需要单独设置cell尺寸或其他属性，请看 ReadMe-UICollectionViewFlowLayout 文件
        flowLayout.itemSize = CGSizeMake(kDeviceWidth, 100);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
        
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _basicCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight) collectionViewLayout:flowLayout];
        [_basicCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCollectionCellIdentify];
        //如果自定义了页眉，初始化时需要注册
        [_basicCollectionView registerClass:[HeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"myHeaderView"];
        _basicCollectionView.backgroundColor = [UIColor whiteColor];
        _basicCollectionView.delegate = self;
        _basicCollectionView.dataSource = self;
    }
    return _basicCollectionView;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }else if (section == 1) {
        return 7;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellIdentify forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgIMG"]];
    }else if (indexPath.section == 1){
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgIMGII"]];
    }
    return cell;
}

//自定义页眉
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    HeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"myHeaderView" forIndexPath:indexPath];
    [header setLabelText:[NSString stringWithFormat:@"我是第%ld个sectionHeader",indexPath.section]];
    return header;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld--%ld", indexPath.section, indexPath.row);
}

//设置指定cell的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1) {
        return CGSizeMake(100, 50);
    }else if (indexPath.section == 1) {
        return CGSizeMake(100, 120);
    }
    return CGSizeMake(kDeviceWidth, 100);
}

//设置指定section的偏移量(内边距)
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(30, 10, 20, 10);
    }else if (section == 1) {
        return UIEdgeInsetsMake(0, 10, 0, 10);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//设置指定区内cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 1) {
        return 5;
    }
    return 10;
}

//指定区内cell之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

//页眉的尺寸，如果是横向滚动，只有宽起作用；如果是纵向滚动，只有高起作用
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 100);
}

//页脚的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(0, 50);
}

@end
