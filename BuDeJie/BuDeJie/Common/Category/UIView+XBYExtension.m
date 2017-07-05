//
//  UIView+XBYExtension.m
//  百思奇解
//
//  Created by XBY on 2016/10/15.
//  Copyright © 2016年 XBY. All rights reserved.
//

#import "UIView+XBYExtension.h"

@implementation UIView (XBYExtension)

-(void)setXBY_X:(CGFloat)XBY_X
{
    CGRect frame = self.frame;
    frame.origin.x = XBY_X;
    self.frame = frame;
}

- (CGFloat)XBY_X
{
    return self.frame.origin.x;
}

- (void)setXBY_Y:(CGFloat)XBY_Y
{
    CGRect frame = self.frame;
    frame.origin.y = XBY_Y;
    self.frame = frame;
}

- (CGFloat)XBY_Y
{
    return self.frame.origin.y;
}

- (void)setXBY_W:(CGFloat)XBY_W
{
    CGRect frame = self.frame;
    frame.size.width = XBY_W;
    self.frame = frame;
}

- (CGFloat)XBY_W
{
    return self.frame.size.width;
}


- (void)setXBY_H:(CGFloat)XBY_H
{
    CGRect frame = self.frame;
    frame.size.height = XBY_H;
    self.frame = frame;
}

-(CGFloat)XBY_H
{
    return self.frame.size.height;
}

- (void)setXBY_size:(CGSize)XBY_size
{
    CGRect frame = self.frame;
    frame.size = XBY_size;
    self.frame = frame;
}

- (CGSize)XBY_size
{
    return  self.frame.size;
}

-(void)setXBY_point:(CGPoint)XBY_point
{
    CGRect frame = self.frame;
    frame.origin = XBY_point;
    self.frame = frame;
}

- (CGPoint)XBY_point
{
    return self.frame.origin;
}


- (void)setXBY_centerX:(CGFloat)XBY_centerX
{
    CGPoint center = self.center;
    center.x = XBY_centerX;
    self.center = center;
}

- (void)setXBY_centerY:(CGFloat)XBY_centerY
{
    CGPoint center = self.center;
    center.y = XBY_centerY;
    self.center = center;
}

- (CGFloat)XBY_centerX
{
    return self.center.x;
}

- (CGFloat)XBY_centerY
{
    return self.center.y;
}


- (CGFloat)XBY_right
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)XBY_bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setXBY_right:(CGFloat)XBY_right
{
    self.XBY_X = XBY_right - self.XBY_W;
}

- (void)setXBY_bottom:(CGFloat)XBY_bottom
{
    self.XBY_Y = XBY_bottom - self.XBY_H;
}



+(instancetype)XBYviewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}




@end
