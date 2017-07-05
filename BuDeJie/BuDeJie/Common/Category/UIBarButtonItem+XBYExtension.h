//
//  UIBarButtonItem+XBYExtension.h
//  百思奇解
//
//  Created by XBY on 2016/10/16.
//  Copyright © 2016年 XBY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XBYExtension)


+ (UIBarButtonItem *)itemWithimage:(NSString *)image highlightedImage:(NSString *)highlightImage target:(id)target action:(SEL)action;

@end
