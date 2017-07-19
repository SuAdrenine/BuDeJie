//
//  XBYRefreshFooter.m
//  BuDeJie
//
//  Created by xby on 2017/7/19.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "XBYRefreshFooter.h"

@implementation XBYRefreshFooter

-(void)prepare {
    [super prepare];
    
    //是否需要自动隐藏
    self.automaticallyHidden = YES;
    
    //是否需要自动重刷新
    self.automaticallyRefresh = NO;
    
    //设置文字
    self.stateLabel.text = @"我正在加载...";
    self.stateLabel.textColor = [UIColor redColor];
}

@end
