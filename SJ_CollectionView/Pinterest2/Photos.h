//
//  Photos.h
//  SJ_CollectionView
//
//  Created by SPIREJ on 16/7/5.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photos : NSObject

@property (nonatomic, strong)NSNumber *h; //高度
@property (nonatomic, strong)NSNumber *w; //宽度
@property (nonatomic, copy)NSString *img; //图片urlString
@property (nonatomic, copy)NSString *price; //价格

@end
