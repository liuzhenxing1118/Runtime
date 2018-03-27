//
//  NSMutableArray+addNil.m
//  Kido Watch
//
//  Created by 振兴 刘 on 2018/3/22.
//  Copyright © 2018年 BaH Cy. All rights reserved.
//

#import "NSMutableArray+addNil.h"
#import <objc/runtime.h>

@implementation NSMutableArray (addNil)

+ (void)load {
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        Method addObject = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(addObject:));
        Method addObjectWithNil = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(nil_addObject:));
        method_exchangeImplementations(addObject, addObjectWithNil);
        
        Method insertObject = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(insertObject:atIndex:));
        Method insertObjectWithNil = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(nil_insertObject:atIndex:));
        method_exchangeImplementations(insertObject, insertObjectWithNil);
        
        
        Method removeObject = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(removeObjectAtIndex:));
        Method removeObjectWithNil = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(invaild_removeObjectAtIndex:));
        method_exchangeImplementations(removeObject, removeObjectWithNil);
    });
}

- (void)nil_addObject:(id)anObject {
    
    if (anObject == nil) {
        [EUtil showToastWithTitle:@"提醒:数组参数为nil"];
        return;
    }
    
    [self nil_addObject:anObject];
}

- (void)nil_insertObject:(id)anObject atIndex:(NSUInteger)index {
    
    if (anObject == nil) {
        [EUtil showToastWithTitle:@"提醒:数组参数为nil"];
        return;
    }
    
    [self nil_insertObject:anObject atIndex:index];
}

- (void)invaild_removeObjectAtIndex:(NSUInteger)index {
    
    if (index < 0 || index >= self.count) {
        [EUtil showToastWithTitle:@"提醒:数组参数越界"];
        return;
    }
    
    [self invaild_removeObjectAtIndex:index];
}

@end
