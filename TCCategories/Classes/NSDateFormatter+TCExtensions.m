//
//  NSDateFormatter+TCExtensions.m
//  TCCategories
//
//  Created by 陈 胜 on 16/10/26.
//  Copyright © 2016年 陈胜. All rights reserved.
//

#import "NSDateFormatter+TCExtensions.h"

@implementation NSDateFormatter (TCExtensions)

+ (instancetype)dateFormatter {
    return [[self alloc] init];
}

+ (instancetype)dateFormatterWithFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (instancetype)defaultDateFormatter {
    return [self dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

@end
