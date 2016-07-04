//
//  WaterLayout.h
//  SJ_CollectionView
//
//  Created by SPIREJ on 16/7/1.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef CGFloat(^HeightBlock)(NSIndexPath *indexPath, CGFloat width);
@interface WaterLayout : UICollectionViewLayout

/** 列数 */
@property (nonatomic, assign) NSInteger lineNumber;
/** 行间距 */
@property (nonatomic, assign) CGFloat rowSpace;
/** 列间距 */
@property (nonatomic, assign) CGFloat lineSpace;
/** 内边距 */
@property (nonatomic, assign) UIEdgeInsets sectionInset;

/** 计算各个item高度的方法 */
- (void)computeIndexCellHeightWithWidthBlock:(CGFloat(^)(NSIndexPath *indexPath, CGFloat width))block;

- (instancetype)initWithLineNumber:(NSInteger)lineNumber rowSpace:(CGFloat)rowSpace lineSpace:(CGFloat)lineSpace sectionInset:(UIEdgeInsets)sectionInset;

@end
