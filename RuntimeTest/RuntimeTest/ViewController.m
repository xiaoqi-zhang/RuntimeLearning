//
//  ViewController.m
//  RuntimeTest
//
//  Created by iermu-xiaoqi.zhang on 2017/4/21.
//  Copyright © 2017年 iermu-xiaoqi.zhang. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Ipad.h"
#import "Person.h"
#import "NSObject+Transfer.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
     交互方法
     */
    Method run = class_getClassMethod([ViewController class], @selector(run));
    Method study = class_getClassMethod([ViewController class], @selector(study));
    method_exchangeImplementations(run, study);
    
    [ViewController run];
    [ViewController study];
    
    /*
     拦截系统方法
     */
    UIImageView *imgV = [UIImageView new];
    imgV.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:imgV];
    UIImage *image = [UIImage imageNamed:@"hehe"];
    [imgV setImage:image];
    
    /*
     给类别添加属性
     */
    UIImage *image1 = [[UIImage alloc] init];
    image1.name = @"image1";
    
    UIImage *image2 = [[UIImage alloc] init];
    image2.name = @"image2";
    
    NSLog(@"%@ \n %@", image1.name, image2.name);
    
    /*
     获取某个类中的所有成员变量的名字和类型
     */
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList([Person class], &outCount);
    for (int i = 0; i < outCount; i++) {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSLog(@"成员变量名：%s 成员变量类型：%s",name,type);
    }
    free(ivars);
    
    /*
     字典转模型
     */
    NSDictionary *dic = @{@"name" : @"张晓琪",
                          @"age" : @(25),
                          @"height" : @(176)
                          };
    Person *person = [Person objectWithDict:dic];
    NSLog(@"%@", person);
    
    /*
     字典转模型
     模型的属性是另外一个类实例
     */
    NSDictionary *dic2 = @{@"name" : @"张晓琪",
                          @"age" : @(25),
                          @"height" : @(176),
                          @"score" : @{@"math" : @99,
                                       @"english" : @90}
                          };
    Person *person2 = [Person objectWithDict:dic2];
    NSLog(@"%@", person2);
    
    /*
     字典转模型
     模型的属性是类实例数组
     */
    NSDictionary *dic3 = @{@"name" : @"张晓琪",
                           @"age" : @(25),
                           @"height" : @(176),
                           @"score" : @{@"math" : @99,
                                        @"english" : @90},
                           @"students" : @[dic2, dic2, dic2]
                           };
    Person *person3 = [Person objectWithDict:dic3];
    NSLog(@"%@", person3);
}

+ (void)run {
    NSLog(@"跑");
}

+ (void)study {
    NSLog(@"学习");
}

@end
