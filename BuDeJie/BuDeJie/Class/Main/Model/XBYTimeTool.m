//
//  XBYTimeTool.m
//  BuDeJie
//
//  Created by xby on 2017/7/12.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "XBYTimeTool.h"

@implementation XBYTimeTool
/**
 *  整型转化字符串
 *  eg：153秒 -> 02:33
 *
 *  program： 返回 02:33 这种类型的字符串
 */
+ (NSString *)getFormatTimeWithTimeInterval:(NSInteger)timeInterval {
    NSInteger sec = (NSInteger)timeInterval%60;
    NSInteger min = (NSInteger)timeInterval/60;
    
    return [NSString stringWithFormat:@"%02zd:%02zd",min,sec];
}

/**
 *  字符串转化整型
 *  eg：02:33 -> 153秒
 *
 *  program： 返回 153秒 这种类型的整型
 */
+ (float)getTimeIntervalWithFormatTime:(NSString *)format {
    //    NSArray *minsec = [format componentsSeparatedByString:@":"];
    //    NSString *min = [minsec firstObject];
    //    NSString *sec = [minsec lastObject];
    //    return min.intValue*60 + sec.floatValue*0.01;
    NSArray *minAsec = [format componentsSeparatedByString:@":"];
    NSString *min = [minAsec firstObject];
    NSString *sec = [minAsec lastObject];
    
    return min.intValue * 60 + sec.floatValue;
}

@end
