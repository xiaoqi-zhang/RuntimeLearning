//
//  Person.h
//  RuntimeTest
//
//  Created by iermu-xiaoqi.zhang on 2017/4/21.
//  Copyright © 2017年 iermu-xiaoqi.zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Score;

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, assign) float height;

@property (nonatomic, assign) double money;

@property (nonatomic, strong) Score *score;

@property (nonatomic, strong) NSMutableArray *students;

@end
