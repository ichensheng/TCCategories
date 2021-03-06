//
//  UIColor+TCExtensions.h
//  TCCategories
//
//  Created by 陈 胜 on 16/5/28.
//  Copyright © 2016年 陈胜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (TCExtensions)

/**
 *  生成随机颜色
 *
 *  @return UIColor
 */
+ (UIColor *)tc_randomColor;

/**
 *  16进制的颜色生成UIColor
 *
 *  @param hexString 类似于#FF00FF
 *
 *  @return UIColor
 */
+ (UIColor *)tc_colorWithHexString:(NSString *)hexString;

@end
