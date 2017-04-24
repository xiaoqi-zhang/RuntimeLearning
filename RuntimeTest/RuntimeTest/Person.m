//
//  Person.m
//  RuntimeTest
//
//  Created by iermu-xiaoqi.zhang on 2017/4/21.
//  Copyright © 2017年 iermu-xiaoqi.zhang. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

- (NSString *)arrayObjectClass {

    return NSStringFromClass([Person class]);
}

@end
