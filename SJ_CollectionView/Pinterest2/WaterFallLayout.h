//
//  WaterFallLayout.h
//  SJ_CollectionView
//
//  Created by SPIREJ on 16/7/5.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaterFallLayout;

@protocol WaterFallLayoutDelegate <NSObject>
@required  //必须实现的代理方法
//返回index位置下item的高度
- (CGFloat)waterFallLayout:(WaterFallLayout *)waterFallLayout heightForItemAtIndex:(NSUInteger)index width:(CGFloat)width;
@optional  //可选择性实现的代理方法
//列数
- (NSUInteger)columnCountOfWaterFallLayout:(WaterFallLayout *)waterFallLayout;
//行间距
- (CGFloat)rowMarginOfWaterFallLayout:(WaterFallLayout *)waterFallLayout;
//列间距
- (CGFloat)columnMarginOfWaterFallLayout:(WaterFallLayout *)waterFallLayout;
//collectionView内边距
- (UIEdgeInsets)edgeInsetsOfWaterFallLayout:(WaterFallLayout *)waterFallLayout;
@end

@interface WaterFallLayout : UICollectionViewLayout

@property (nonatomic, weak) id<WaterFallLayoutDelegate>delegate;

@end
