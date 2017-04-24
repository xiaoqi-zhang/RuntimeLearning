//
//  NSObject+Transfer.h
//  RuntimeTest
//
//  Created by iermu-xiaoqi.zhang on 2017/4/24.
//  Copyright © 2017年 iermu-xiaoqi.zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Transfer)

+ (instancetype)objectWithDict:(NSDictionary *)dict;

- (NSString *)arrayObjectClass;

@end
