//
//  XBYQuicklyLoginView.m
//  BuDeJie
//
//  Created by xby on 2017/7/6.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "XBYQuicklyLoginView.h"
#import <Masonry.h>

@interface XBYQuicklyLoginView()

@property (nonatomic, strong) UIImageView *leftLineImageView;
@property (nonatomic, strong) UIImageView *rightLineImageView;
@property (nonatomic, strong) UILabel *titleLB;

@property (nonatomic, strong) UIButton *shareBtnOne;
@property (nonatomic, strong) UIButton *shareBtnTwo;
@property (nonatomic, strong) UIButton *shareBtnThree;

@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation XBYQuicklyLoginView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

-(void)setupSubViews {
    [self addSubview:self.leftLineImageView];
    [self addSubview:self.rightLineImageView];
    [self addSubview:self.titleLB];
    
    [self addSubview:self.shareBtnOne];
    [self addSubview:self.shareBtnTwo];
    [self addSubview:self.shareBtnThree];
    
    self.buttonArray = @[].mutableCopy;
    [self.buttonArray addObject:self.shareBtnOne];
    [self.buttonArray addObject:self.shareBtnTwo];
    [self.buttonArray addObject:self.shareBtnThree];
    
    self.titleLB.text = @"快速登录";
    self.leftLineImageView.backgroundColor = [UIColor clearColor];
    self.leftLineImageView.contentMode =  UIViewContentModeScaleAspectFit;
//    self.leftLineImageView.contentMode =  UIViewContentModeCenter;
//    self.rightLineImageView.backgroundColor = [UIColor clearColor];
    
    self.rightLineImageView.contentMode =  UIViewContentModeScaleAspectFit;
    
    
    [self.shareBtnOne setImage:[UIImage imageNamed:@"login_sina_icon"] forState:UIControlStateNormal];
    [self.shareBtnOne setImage:[UIImage imageNamed:@"login_sina_icon_click"] forState:UIControlStateSelected];
    [self.shareBtnTwo setImage:[UIImage imageNamed:@"login_QQ_icon"] forState:UIControlStateNormal];
    [self.shareBtnTwo setImage:[UIImage imageNamed:@"login_QQ_icon_click"] forState:UIControlStateSelected];
    [self.shareBtnThree setImage:[UIImage imageNamed:@"login_tecent_icon"] forState:UIControlStateNormal];
    [self.shareBtnThree setImage:[UIImage imageNamed:@"login_tecent_icon_click"] forState:UIControlStateSelected];

}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self setupSubViewsFrame];
}

-(void)setupSubViewsFrame {
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 24));
        make.top.equalTo(self).offset(10);
    }];
    
    [self.leftLineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self.titleLB.mas_left);
        make.top.bottom.equalTo(self.titleLB);
    }];
    
    [self.rightLineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLB.mas_right);
        make.right.equalTo(self);
        make.top.bottom.equalTo(self.titleLB);
    }];
//    
//    [self.buttonArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:0 tailSpacing:0];
//    
//    [self.buttonArray mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.titleLB.mas_bottom);
//        make.left.right.bottom.equalTo(self);
//    }];
//    [self.buttonArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
//                       withFixedSpacing:90 leadSpacing:0 tailSpacing:0];
//    
//    [self.buttonArray mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(self);
//        make.top.equalTo(self.titleLB.mas_bottom);
//        
//    }];
    
    [self.shareBtnOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.top.equalTo(self.titleLB.mas_bottom);
        make.width.mas_equalTo(self).multipliedBy(0.33);
    }];
    
    [self.shareBtnTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shareBtnOne.mas_right);
        make.top.equalTo(self.titleLB.mas_bottom);
        make.bottom.equalTo(self);
        make.width.mas_equalTo(self).multipliedBy(0.33);
    }];
    
    [self.shareBtnThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.equalTo(self.titleLB.mas_bottom);
        make.bottom.equalTo(self);
        make.width.mas_equalTo(self).multipliedBy(0.33);
        
    }];
    
    [self.shareBtnOne verticalImageAndTitle:5];
    [self.shareBtnTwo verticalImageAndTitle:5];
    [self.shareBtnThree verticalImageAndTitle:5];

}

#pragma mark - Getter

ImageViewGetter(leftLineImageView, @"login_register_left_line")
ImageViewGetter(rightLineImageView, @"login_register_right_line")
LabelGetter(titleLB, NSTextAlignmentCenter, [UIColor whiteColor], [UIFont systemFontOfSize:CalcFont(13)])

ButtonGetterWithCode(shareBtnOne, [UIColor whiteColor], [UIFont systemFontOfSize:CalcFont(15.5)], nil, 0,[_shareBtnOne setTitle:@"新浪微博" forState:UIControlStateNormal];)
ButtonGetterWithCode(shareBtnTwo, [UIColor whiteColor], [UIFont systemFontOfSize:CalcFont(15.5)], nil, 0,[_shareBtnTwo setTitle:@"QQ" forState:UIControlStateNormal];)
ButtonGetterWithCode(shareBtnThree, [UIColor whiteColor], [UIFont systemFontOfSize:CalcFont(15.5)], nil, 0,[_shareBtnThree setTitle:@"腾讯微博" forState:UIControlStateNormal];)

@end
