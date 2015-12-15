//
//  NSObject+ZHAddForMethodSwizzing.m
//  ZHCategoriesDemo
//
//  Created by 慢慢来会更快 on 15/12/12.
//  Copyright © 2015年 wuzhihe. All rights reserved.
//

#import "NSObject+ZHAddForMethodSwizzing.h"
#import <objc/runtime.h>

@implementation NSObject (ZHAddForMethodSwizzing)

/**
 *  替换类的方法
 *
 *  @param class            需要被替换的类
 *  @param originalSelector 需要被替换的函数
 *  @param swizzedClass     替换使用的类
 *  @param swizzledSelector 替换时使用的函数
 *
 *  @return 替换是否成功
 */
+ (BOOL)zh_swizzleClass:(Class) class original:(SEL)originalSelector withSwizzedClass:(Class)swizzedClass swizzledSelector:(SEL)swizzledSelector
{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(swizzedClass, swizzledSelector);
    
    if (!swizzledMethod) {
        NSLog(@"selector %@ in %@ is not found", NSStringFromSelector(swizzledSelector), swizzedClass);
        return NO;
    }
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod)
    {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else  //originalSelector 存在
    {
        //判断typeEncoding是否一样
        NSString *oriTypeEcodeing = [NSString stringWithCString:method_getTypeEncoding(originalMethod) encoding:NSUTF8StringEncoding];
        NSString *swizzedTypeEcodeing = [NSString stringWithCString:method_getTypeEncoding(swizzledMethod) encoding:NSUTF8StringEncoding];
        
        if (![oriTypeEcodeing isEqualToString:swizzedTypeEcodeing]) {
            NSLog(@"Trying to swizze methods with different typeEncodeing");
            return NO;
        }
        
        //为类添加新的实例方法
        BOOL didAddSwizzedMethod =
        class_addMethod(class,
                        swizzledSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (!didAddSwizzedMethod) {
            NSLog(@"class:%@ already has method:%@", class, NSStringFromSelector(method_getName(swizzledMethod)));
            return NO;
        }
        
        Method originalMethodNew = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethodNew = class_getInstanceMethod(class, swizzledSelector);
        
        method_exchangeImplementations(originalMethodNew, swizzledMethodNew);
    }
    
    return YES;
}

/**
 *  替换类的元类的方法
 *
 *  @param class            需要被替换的类
 *  @param originalSelector 需要被替换的函数
 *  @param swizzedClass     替换使用的类
 *  @param swizzledSelector 替换时使用的函数
 *
 *  @return 替换是否成功
 */
+ (BOOL)zh_swizzleMetaClass:(Class) class original:(SEL)originalSelector withSwizzedClass:(Class)swizzedClass swizzledSelector:(SEL)swizzledSelector
{
    return [self zh_swizzleClass:objc_getMetaClass(class_getName(class)) original:originalSelector withSwizzedClass:objc_getMetaClass(class_getName(swizzedClass)) swizzledSelector:swizzledSelector];
}

@end
