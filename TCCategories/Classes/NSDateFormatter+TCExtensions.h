//
//  NSDateFormatter+TCExtensions.h
//  TCCategories
//
//  Created by 陈 胜 on 16/10/26.
//  Copyright © 2016年 陈胜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (TCExtensions)

+ (instancetype)dateFormatter;
+ (instancetype)dateFormatterWithFormat:(NSString *)dateFormat;
+ (instancetype)defaultDateFormatter;

@end
