//
//  WaterLayout.m
//  SJ_CollectionView
//
//  Created by SPIREJ on 16/7/1.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "WaterLayout.h"

@interface WaterLayout ()

/** 存放每列高度的字典 */
@property (nonatomic, strong)NSMutableDictionary *dicOfHeight;
/** 存放所有item的attributes属性 */
@property (nonatomic, strong)NSMutableArray *array;
/** 计算每个item高度的block */
@property (nonatomic, copy)HeightBlock block;

@end

@implementation WaterLayout

- (instancetype)initWithLineNumber:(NSInteger)lineNumber rowSpace:(CGFloat)rowSpace lineSpace:(CGFloat)lineSpace sectionInset:(UIEdgeInsets)sectionInset {
    if (self = [super init]) {
        self.lineNumber = lineNumber;
        self.rowSpace = rowSpace;
        self.lineSpace = lineSpace;
        self.sectionInset = sectionInset;
        _dicOfHeight = [NSMutableDictionary dictionary];
        _array = [NSMutableArray array];
    }
    return self;
}

/**
 *  准备布局时调用
 */
- (void)prepareLayout {
    [super prepareLayout];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    //初始化好每列的高度
    for (NSInteger i = 0; i < self.lineNumber; i++) {
        [_dicOfHeight setObject:@(self.sectionInset.top) forKey:[NSString stringWithFormat:@"%ld",i]];
    }
    //得到每个items的属性值进行存储
    for (NSInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [_array addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
}

/**
 *  设置可滚动区域
 */
- (CGSize)collectionViewContentSize {
    __block NSString *maxHeightLine = @"0";
    [_dicOfHeight enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([_dicOfHeight[maxHeightLine] floatValue] < [obj floatValue]) {
            maxHeightLine = key;
        }
    }];
    return CGSizeMake(self.collectionView.bounds.size.width, [_dicOfHeight[maxHeightLine] floatValue] + self.sectionInset.bottom);
}

/**
    计算indexPath下item属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    //创建一个item属性attr
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //item宽
    CGFloat itemW = (self.collectionView.bounds.size.width - (self.sectionInset.left+self.sectionInset.right) - (self.lineNumber-1)*_lineSpace)/_lineNumber;
    //item高
    CGFloat itemH;
    if (self.block != nil) {
        itemH = self.block(indexPath, itemW);
    }else {
        NSAssert(itemH != 0, @"balabala");
    }
    //计算item的frame
    CGRect frame;
    frame.size = CGSizeMake(itemW, itemH);
    //循环遍历找出高度最短行
    __block NSString *lineMinHeight = @"0";
    [_dicOfHeight enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([_dicOfHeight[lineMinHeight] floatValue] > [obj floatValue]) {
            lineMinHeight = key;
        }
    }];
    NSInteger line = [lineMinHeight integerValue];
    //找出最短行后，计算item位置
    frame.origin = CGPointMake(self.sectionInset.left + line * (itemW + self.lineSpace), [_dicOfHeight[lineMinHeight]floatValue]);
    _dicOfHeight[lineMinHeight] = @(frame.size.height + self.rowSpace + [_dicOfHeight[lineMinHeight] floatValue]);
    attr.frame = frame;
    return attr;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return _array;
}

- (void)computeIndexCellHeightWithWidthBlock:(CGFloat (^)(NSIndexPath *, CGFloat))block {
    if (self.block != block) {
        self.block = block;
    }
}


@end
