//
//  XBYTimeTool.h
//  BuDeJie
//
//  Created by xby on 2017/7/12.
//  Copyright © 2017年 xby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBYTimeTool : NSObject
/*  整型转化字符串 */
+ (NSString *)getFormatTimeWithTimeInterval:(NSInteger)timeInterval;
/*  字符串转化整型 */
+ (float)getTimeIntervalWithFormatTime:(NSString *)format;

@end
