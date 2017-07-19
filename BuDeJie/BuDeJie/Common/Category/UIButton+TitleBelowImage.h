//
//  UIButton+TitleBelowImage.h
//  BuDeJie
//
//  Created by xby on 2017/7/6.
//  Copyright © 2017年 xby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (TitleBelowImage)
#warning 需先确定frame才有效果
- (void)verticalImageAndTitle:(CGFloat)spacing;

@end
