//
//  CommonMacro.h
//  BuDeJie
//
//  Created by xby on 2017/6/21.
//  Copyright © 2017年 xby. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h

#ifdef DEBUG
#define XBYLog(...) NSLog(__VA_ARGS__)
#else
#define XBYLog(...)
#endif

#define XBYLogFunc XBYLog(@"%s",__func__);

/* 颜色 */
#define XBYARGBColor(a, r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define XBYColor(r, g, b) XBYARGBColor(255, (r), (g), (b))

#define XBYRandomColor XBYColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define XBYrayColor(v) XBYColor((v), (v), (v))
#define XBYCommonBgColor XBYrayColor(206)

/* View宽高 */
#define XBYSelfViewWidth self.view.bounds.size.width
#define XBYSelfViewHeight self.view.bounds.size.height

/* 屏幕有关 */
#define XBYkScreenWidth [UIScreen mainScreen].bounds.size.width
#define XBYkScreenHeight [UIScreen mainScreen].bounds.size.height

#define iPone6   ([UIScreen mainScreen].bounds.size.height == 667)
#define iPone6P   ([UIScreen mainScreen].bounds.size.height == 736)
#define iPone5   ([UIScreen mainScreen].bounds.size.height == 568)
#define iPone4  ([UIScreen mainScreen].bounds.size.height == 480)


#define XBYWrite(responseObject,filename) [responseObject writeToFile:[NSString stringWithFormat:@"/Users/XBY/Desktop/%@.plist",filename] atomically:YES];

#define LogController

#endif /* CommonMacro_h */
