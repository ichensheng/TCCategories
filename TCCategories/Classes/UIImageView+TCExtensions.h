//
//  UIImageView+TCExtensions.h
//  TCCategories
//
//  Created by 陈 胜 on 16/6/20.
//  Copyright © 2016年 陈胜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (TCExtensions)

/**
 *  设置图片，带圆角
 *
 *  @param image 图片
 */
- (void)tc_setImageWithCorner:(UIImage *)image;

/**
 *  设置圆角，大概5像素
 */
- (void)tc_setCorner;

@end
