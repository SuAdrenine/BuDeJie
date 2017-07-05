//
//  UIViewController+Debug.m
//  iOSDemoTest
//
//  Created by xby on 2017/2/17.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "UIViewController+Debug.h"
#include <objc/runtime.h>

@implementation UIViewController (Debug)

+ (void)load
{
#ifdef LogController
    Method viewWillAppear = class_getInstanceMethod(self, @selector(viewWillAppear:));
    Method logViewWillAppear = class_getInstanceMethod(self, @selector(logViewWillAppear:));
    method_exchangeImplementations(viewWillAppear, logViewWillAppear);
    
#endif
}

- (void)logViewWillAppear:(BOOL)animated
{
    NSString *className = NSStringFromClass([self class]);
    if ([className containsString:@"UI"]) { //过滤系统VC名称
        return;
    }
    if ([className containsString:@"Controller"]) {
        NSLog(@"页面 %@  ----- WillAppear",className);
    }
    [self logViewWillAppear:animated];
}

@end
