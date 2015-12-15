//
//  ZHClassBCondition3.m
//  ZHMethodSwizzingDemo
//
//  Created by 慢慢来会更快 on 15/12/15.
//  Copyright © 2015年 慢慢来会更快. All rights reserved.
//

#import "ZHClassBCondition3.h"

@implementation ZHClassBCondition3

- (void)funcB
{
    NSLog(@"ZHClassBCondition3 funcB");
    [self funcB];
}

@end
