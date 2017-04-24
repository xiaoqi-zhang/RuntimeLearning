//
//  UIImage+Ipad.m
//  RuntimeTest
//
//  Created by iermu-xiaoqi.zhang on 2017/4/21.
//  Copyright © 2017年 iermu-xiaoqi.zhang. All rights reserved.
//

#import "UIImage+Ipad.h"
#import <objc/runtime.h>

#define IS_IPHONE5    [UIScreen mainScreen].bounds.size.height == 568

char nameKey;

@implementation UIImage (Ipad)

+ (void)load {

    Method m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
    Method m2 = class_getClassMethod([UIImage class], @selector(xx_imageWithNamed:));
    method_exchangeImplementations(m1, m2);
}

+ (UIImage *)xx_imageWithNamed:(NSString *)name {

    if (IS_IPHONE5) {
        name = [name stringByAppendingString:@".Ipad"];
    }
    return [UIImage xx_imageWithNamed:name];
}

- (void)setName:(NSString *)name {

    objc_setAssociatedObject(self, &nameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name {

    return objc_getAssociatedObject(self, &nameKey);
}

@end
