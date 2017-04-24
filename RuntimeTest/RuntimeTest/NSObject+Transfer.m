//
//  NSObject+Transfer.m
//  RuntimeTest
//
//  Created by iermu-xiaoqi.zhang on 2017/4/24.
//  Copyright © 2017年 iermu-xiaoqi.zhang. All rights reserved.
//

#import "NSObject+Transfer.h"
#import <objc/runtime.h>

@implementation NSObject (Transfer)

+ (instancetype)objectWithDict:(NSDictionary *)dict {

    //self：在类方法中指代类本身，在实例方法中指代实例本身
    NSObject *object = [[self alloc] init];
    [object setDict:dict];
    return object;
}

- (instancetype)setDict:(NSDictionary *)dict {
    
    Class c = self.class;
    while (c && c!= [NSObject class]) {
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(c, &outCount);
        for (NSInteger i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            key = [key substringFromIndex:1];
            id value = dict[key];
            if (!value) continue;
            
            NSString *typeName = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
            NSRange range = [typeName rangeOfString:@"@"];
            if (range.location != NSNotFound) {
                typeName = [typeName substringWithRange:NSMakeRange(2, typeName.length - 3)];
                if (![typeName hasPrefix:@"NS"]) {
                    Class class = NSClassFromString(typeName);
                    value = [class objectWithDict:dict[key]];
                } else if ([typeName isEqualToString:@"NSArray"]
                           || [typeName isEqualToString:@"NSMutableArray"]) {
                    NSArray *array = (NSArray *)value;
                    NSMutableArray *mArray = [NSMutableArray array];
                    Class class;
                    if ([self respondsToSelector:@selector(arrayObjectClass)]) {
                        
                        NSString *classStr = [self arrayObjectClass];
                        class = NSClassFromString(classStr);
                    }
                    for (NSDictionary *subDict in array) {
                        [mArray addObject:[self.class objectWithDict:subDict]];
                    }
                    value = mArray;
                }
            }
            [self setValue:value forKeyPath:key];
        }
        free(ivars);
        c = [c superclass];
    }
    return self;
}

@end
