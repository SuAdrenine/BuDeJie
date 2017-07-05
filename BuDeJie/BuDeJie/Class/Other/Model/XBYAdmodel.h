//
//  XBYAdmodel.h
//  BuDeJie
//
//  Created by xby on 2017/7/4.
//  Copyright © 2017年 xby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBYAdmodel : NSObject

/** 图片URL */
@property (nonatomic,copy) NSString *w_picurl;
/** 点击图片的回调网址 */
@property (nonatomic,copy) NSString *ori_curl;
/** 宽 */
@property (nonatomic, assign) NSInteger w;
/** 高 */
@property (nonatomic, assign) NSInteger h;

@end
