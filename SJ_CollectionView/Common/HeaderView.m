//
//  HeaderView.m
//  SJ_CollectionView
//
//  Created by SPIREJ on 16/7/1.
//  Copyright © 2016年 SPIREJ. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        label.textAlignment = NSTextAlignmentCenter;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (void)setLabelText:(NSString *)text {
    self.titleLabel.text = text;
}

@end
