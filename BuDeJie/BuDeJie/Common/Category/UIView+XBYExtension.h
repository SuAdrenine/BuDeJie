//
//  UIView+XBYExtension.h
//  百思奇解
//
//  Created by XBY on 2016/10/15.
//  Copyright © 2016年 XBY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XBYExtension)


@property (nonatomic,assign) CGFloat XBY_X;
@property (nonatomic,assign) CGFloat XBY_Y;
@property (nonatomic,assign) CGFloat XBY_W;
@property (nonatomic,assign) CGFloat XBY_H;
@property (nonatomic,assign) CGSize  XBY_size;
@property (nonatomic,assign) CGPoint XBY_point;
@property (assign, nonatomic) CGFloat XBY_centerX;
@property (assign, nonatomic) CGFloat XBY_centerY;
@property (nonatomic,assign) CGFloat XBY_right;
@property (nonatomic,assign) CGFloat XBY_bottom;

+(instancetype)XBYviewFromXib;

@end
