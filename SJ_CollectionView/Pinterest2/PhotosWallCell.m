//
//  PhotosWallCell.m
//  SJ_CollectionView
//
//  Created by SPIREJ on 16/7/4.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "PhotosWallCell.h"

@interface PhotosWallCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
@implementation PhotosWallCell

- (void)setPhotos:(Photos *)photos {
    _photos = photos;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:photos.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    self.priceLabel.text = photos.price;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
