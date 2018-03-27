//
//  UISwitch+color.m
//  Kido Watch
//
//  Created by 振兴 刘 on 2018/3/27.
//  Copyright © 2018年 BaH Cy. All rights reserved.
//

#import "UISwitch+color.h"

@implementation UISwitch (color)

+ (void)load {
    
    Method onMethod = class_getInstanceMethod(self, @selector(setOn:animated:));
    Method color_onMethod = class_getInstanceMethod(self, @selector(color_setOn:animated:));
    
    method_exchangeImplementations(onMethod, color_onMethod);
}

- (void)color_setOn:(BOOL)on animated:(BOOL)animated {
    
    [self setOnTintColor:[UIColor colorWithRed:44/255.0f green:156/255.0f blue:255/255.0f alpha:1]];
    
    [self color_setOn:on animated:animated];
}

@end
