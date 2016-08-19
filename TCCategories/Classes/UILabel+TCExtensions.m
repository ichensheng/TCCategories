//
//  UILabel+TCExtensions.m
//  TCCategories
//
//  Created by 陈 胜 on 16/8/19.
//  Copyright © 2016年 陈胜. All rights reserved.
//

#import "UILabel+TCExtensions.h"
#import "JRSwizzle.h"
#import <objc/runtime.h>

NSString const * kInsets = @"kInsets";

@implementation UILabel (TCExtensions)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error;
        BOOL result = [[self class] jr_swizzleMethod:@selector(drawTextInRect:)
                                          withMethod:@selector(tc_drawTextInRect:)
                                               error:&error];
        if (!result || error) {
            NSLog(@"Can't swizzle methods - %@", [error description]);
        }
    });
}

- (void)tc_drawTextInRect:(CGRect)rect {
    [self tc_drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}

- (void)setInsets:(UIEdgeInsets)insets {
    objc_setAssociatedObject(self, &kInsets, [NSValue valueWithUIEdgeInsets:insets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)insets {
    UIEdgeInsets insets;
    [objc_getAssociatedObject(self, &kInsets) getValue:&insets];
    return insets;
}

@end
