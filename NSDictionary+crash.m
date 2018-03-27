//
//  NSDictionary+crash.m
//  Kido Watch
//
//  Created by 振兴 刘 on 2018/3/23.
//  Copyright © 2018年 BaH Cy. All rights reserved.
//

#import "NSDictionary+crash.h"
#import <objc/runtime.h>

@implementation NSDictionary (crash)

+ (void)load {
    
    Method oldMethod = class_getClassMethod([NSDictionary class], @selector(dictionaryWithObjects:forKeys:count:));

    Method newMethod = class_getClassMethod([NSDictionary class], @selector(crash_dictionaryWithObjects:forKeys:count:));

    method_exchangeImplementations(oldMethod, newMethod);
}

//+ (instancetype)dictionaryWithObjects:(const ObjectType _Nonnull [_Nullable])objects forKeys:(const KeyType <NSCopying> _Nonnull [_Nullable])keys count:(NSUInteger)cnt;
+ (instancetype)crash_dictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt {
    
    id instance = nil;
    
    @try {
        instance = [self crash_dictionaryWithObjects:objects forKeys:keys count:cnt];
    } @catch (NSException *exception) {
        
        id  _Nonnull __unsafe_unretained  newObject[cnt];
        id  _Nonnull __unsafe_unretained  newoKey[cnt];
        
        for (int i = 0; i < cnt; i++) {
            
            if (objects[i] && keys[i]) {
                newObject[i] = objects[i];
                newoKey[i] = keys[i];
            }
            else {
                newObject[i] = objects[i] ? objects[i] : @"提醒:字典参数为nil";
                newoKey[i] = keys[i] ? keys[i] : @"提醒:字典参数为nil";
            }
        }
        
        instance = [self crash_dictionaryWithObjects:newObject forKeys:newoKey count:cnt];
    } @finally {
        
    }
    
    return instance;
}

@end
