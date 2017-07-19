//
//  UIButton+TitleBelowImage.m
//  BuDeJie
//
//  Created by xby on 2017/7/6.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "UIButton+TitleBelowImage.h"

@implementation UIButton (TitleBelowImage)

- (void)verticalImageAndTitle:(CGFloat)spacing {
    self.titleLabel.backgroundColor = [UIColor clearColor];
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    //sizeWithFont已废弃
//    CGSize textSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
    
    CGSize constrainedSize = CGSizeMake(0, MAXFLOAT);
    CGRect textRect = [self.titleLabel.text boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil];
    CGSize textSize = textRect.size;
    
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}

@end
