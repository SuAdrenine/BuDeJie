//
//  XBYComment.h
//  BuDeJie
//
//  Created by xby on 2017/7/5.
//  Copyright © 2017年 xby. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XBYUser;

@interface XBYComment : NSObject

@property (nonatomic,strong) XBYUser *user;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *voiceuri;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
@property (nonatomic,copy) NSString *ID;

@end
