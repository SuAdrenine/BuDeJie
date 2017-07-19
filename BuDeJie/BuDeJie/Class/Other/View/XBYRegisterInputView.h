//
//  XBYRegisterInputView.h
//  BuDeJie
//
//  Created by xby on 2017/7/6.
//  Copyright © 2017年 xby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBYRegisterInputView : UIView

/**
 获取用户名
 */
-(NSString *)getUserName;

/**
 获取明文密码
 */
-(NSString *)getPassword;

/**
 获取MD5密码
 */
-(NSString *)getMD5Password;

@end
