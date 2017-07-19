//
//  XBYRefreshHeard.m
//  BuDeJie
//
//  Created by xby on 2017/7/19.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "XBYRefreshHeard.h"

@interface XBYRefreshHeard ()

@property (nonatomic, weak) UIImageView *logo;

@end

@implementation XBYRefreshHeard

-(void)prepare {
    [super prepare];
    self.automaticallyChangeAlpha = YES;
    self.stateLabel.textColor = [UIColor redColor];
    self.lastUpdatedTimeLabel.textColor = [UIColor redColor];
    [self setTitle:@"下拉一下试试" forState:MJRefreshStateIdle];
    [self setTitle:@"松开绽放精彩" forState:MJRefreshStatePulling];
    [self setTitle:@"迅速加载数据..." forState:MJRefreshStateRefreshing];
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    [self addSubview:logo];
    self.logo = logo;
}

/**
 摆放子控件
 */
-(void)placeSubviews {
    [super placeSubviews];
    
    self.logo.XBY_W = self.XBY_W * 0.6;
    self.logo.XBY_H = 30;
    self.logo.XBY_centerX = self.XBY_centerX;
    self.logo.XBY_Y = -30;
}

@end
