//
//  UIImageView+TCExtensions.m
//  TCCategories
//
//  Created by 陈 胜 on 16/6/20.
//  Copyright © 2016年 陈胜. All rights reserved.
//

#import "UIImageView+TCExtensions.h"
#import "Masonry.h"

@implementation UIImageView (TCExtensions)

/**
 *  设置图片，带圆角
 *
 *  @param image 图片
 */
- (void)tc_setImageWithCorner:(UIImage *)image {
    self.image = image;
    [self tc_setCorner];
}

/**
 *  设置圆角，大概5像素
 */
- (void)tc_setCorner {
    UIImageView *cornerImageView = [[UIImageView alloc] initWithImage:[self tc_cornerImage]];
    [self addSubview:cornerImageView];
    __weak typeof(self) weakSelf = self;
    [cornerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
}

/**
 *  返回圆角底图
 */
- (UIImage *)tc_cornerImage {
    UIImage *radiusImage = [UIImage imageNamed:@"CornerRadius"];
    return [radiusImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)
                                       resizingMode:UIImageResizingModeStretch];
}

@end
