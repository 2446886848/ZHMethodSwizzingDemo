//
//  ViewController.m
//  ZHMethodSwizzingDemo
//
//  Created by 慢慢来会更快 on 15/12/15.
//  Copyright © 2015年 慢慢来会更快. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "NSObject+ZHAddForMethodSwizzing.h"
#import "ZHClassACondition1.h"
#import "ZHClassBCondition1.h"
#import "ZHClassACondition2.h"
#import "ZHClassBCondition2.h"
#import "ZHClassACondition3.h"
#import "ZHClassBCondition3.h"
#import "ZHClassACondition4.h"
#import "ZHClassBCondition4.h"
#import "ZHClassACondition5.h"
#import "ZHClassBCondition5.h"
#import "ZHClassACondition6.h"
#import "ZHClassBCondition6.h"
#import "ZHClassACondition7.h"
#import "ZHClassBCondition7.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self testSituation1];
    
//    [self testSituation2];
    
//    [self testSituation3];
    
//    [self testSituation4];
    
//    [self testSituation5];
    
//    [self testSituation6];
    
//    [self testClassMethodSwizzing];
    
    [self testSwizzingClassWithInstanceMethod];
}

/**
 *  @condition1: ClassB dosen't have funcB
 *
 *  @expect: swizze failed
 */
- (void)testSituation1
{
    [NSObject zh_swizzleClass:[ZHClassACondition1 class] original:@selector(funcA) withSwizzedClass:[ZHClassBCondition1 class] swizzledSelector:@selector(funcB)];
    ZHClassACondition1 *classA1 = [[ZHClassACondition1 alloc] init];
    [classA1 performSelector:@selector(funcA)];
}

/**
 *  @condition2: ClassA has nothing, ClassB has funcB
 *
 *  @expect: ZHClassBCondition2 funcB
 */
- (void)testSituation2
{
    ZHClassACondition2 *classA2 = [[ZHClassACondition2 alloc] init];
    [NSObject zh_swizzleClass:[ZHClassACondition2 class] original:@selector(funcA) withSwizzedClass:[ZHClassBCondition2 class] swizzledSelector:@selector(funcB)];
    [classA2 performSelector:@selector(funcA)];
}

/**
 *  @condition3: ClassA has funcA, ClassB has funcB
 *
 *  @expect: ZHClassBCondition3 funcB + ZHClassACondition3 funcA
 */
- (void)testSituation3
{
    ZHClassACondition3 *classA3 = [[ZHClassACondition3 alloc] init];
    [NSObject zh_swizzleClass:[ZHClassACondition3 class] original:@selector(funcA) withSwizzedClass:[ZHClassBCondition3 class] swizzledSelector:@selector(funcB)];
    [classA3 performSelector:@selector(funcA)];
}

/**
 *  @condition4: ClassA has funcB, ClassB has funcB
 *
 *  @expect: ZHClassBCondition4 funcB
 */
- (void)testSituation4
{
    ZHClassACondition4 *classA4 = [[ZHClassACondition4 alloc] init];
    [NSObject zh_swizzleClass:[ZHClassACondition4 class] original:@selector(funcA) withSwizzedClass:[ZHClassBCondition4 class] swizzledSelector:@selector(funcB)];
    [classA4 performSelector:@selector(funcA)];
}

/**
 *  @condition5: ClassA has funcA and funcB, ClassB has funcB
 *
 *  @expect: class:ZHClassACondition5 already has method:funcB + ZHClassACondition5 funcA
 */
- (void)testSituation5
{
    ZHClassACondition5 *classA5 = [[ZHClassACondition5 alloc] init];
    [NSObject zh_swizzleClass:[ZHClassACondition5 class] original:@selector(funcA) withSwizzedClass:[ZHClassBCondition5 class] swizzledSelector:@selector(funcB)];
    [classA5 performSelector:@selector(funcA)];
}

/**
 *  @condition6: ClassA has funcA:, ClassB has funcB
 *
 *  @expect: Trying to swizze methods with different typeEncodeing + ZHClassACondition6 funcA str = aaa
 */
- (void)testSituation6
{
    ZHClassACondition6 *classA6 = [[ZHClassACondition6 alloc] init];
    [NSObject zh_swizzleClass:[ZHClassACondition6 class] original:@selector(funcA:) withSwizzedClass:[ZHClassBCondition6 class] swizzledSelector:@selector(funcB)];
    [classA6 performSelector:@selector(funcA:) withObject:@"aaa"];
}

/**
 *  @testClassMethodSwizzing: classMehtod swizzing
 *
 *  @expect: ZHClassBCondition7 funcB
 */
- (void)testClassMethodSwizzing
{
    [NSObject zh_swizzleMetaClass:[ZHClassACondition7 class] original:@selector(funcA) withSwizzedClass:[ZHClassBCondition7 class] swizzledSelector:@selector(funcB)];
    [ZHClassACondition7 funcA];
}

/**
 *  @testClassMethodSwizzing: swizz class method with instance method
 *
 *  @expect: ZHClassBCondition6 funcB
 */
- (void)testSwizzingClassWithInstanceMethod
{
    [NSObject zh_swizzleClass:objc_getMetaClass(NSStringFromClass([ZHClassACondition7 class]).UTF8String) original:@selector(funcA) withSwizzedClass:[ZHClassBCondition6 class] swizzledSelector:@selector(funcB)];
    [ZHClassACondition7 funcA];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
