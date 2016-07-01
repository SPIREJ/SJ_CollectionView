//
//  HeaderView.h
//  SJ_CollectionView
//
//  Created by SPIREJ on 16/7/1.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UICollectionReusableView

@property (nonatomic, strong) UILabel *titleLabel;
- (void)setLabelText:(NSString *)text;

@end
