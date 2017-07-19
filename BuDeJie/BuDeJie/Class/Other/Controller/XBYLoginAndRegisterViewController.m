//
//  XBYLoginAndRegisterViewController.m
//  BuDeJie
//
//  Created by xby on 2017/7/6.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "XBYLoginAndRegisterViewController.h"
#import <Masonry.h>
#import "XBYLoginInputView.h"
#import "XBYRegisterInputView.h"
#import "XBYQuicklyLoginView.h"

@interface XBYLoginAndRegisterViewController ()

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UIView *topView;  //包裹俩按钮（取消，切换登录与注册）
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *loginOrRegisterBtn;

@property (nonatomic, strong) UIView *middleView;   //包裹中间输入框

/**
 其实用纯代码布局并不需要两个类似的View，可以把view直接在这里控制好，注册显示什么，登录显示什么，但是这里这么做，只是为了记录一点知识
 */
@property (nonatomic, strong) XBYLoginInputView *loginView;    //登录的中间输入框
@property (nonatomic, strong) XBYRegisterInputView *registerView; //注册的中间输入框
@property (nonatomic, strong) XBYQuicklyLoginView *bottomView;   //底部快速登录

@end

@implementation XBYLoginAndRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviews];
}

-(void)setupSubviews {
    //背景
    [self.view addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    //顶部
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.cancelBtn];
    [self.topView addSubview:self.loginOrRegisterBtn];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).offset(18);
        make.size.mas_equalTo(CGSizeMake(14, 14));
        make.centerY.equalTo(self.topView);
    }];
    
    [self.loginOrRegisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.topView).offset(-5);
        make.top.equalTo(self.topView).offset(5);
        make.width.mas_equalTo(100);
    }];

    //中部
    [self.view addSubview:self.middleView];
    [self.middleView addSubview:self.loginView];
    [self.middleView addSubview:self.registerView];
    
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(50);
        make.left.equalTo(self.view);
        make.height.equalTo(@200);
        make.width.equalTo(self.view).multipliedBy(2.0);
    }];
    
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.middleView);
        make.width.equalTo(self.middleView).multipliedBy(0.5);
    }];
    
    [self.registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.middleView);
        make.width.equalTo(self.middleView).multipliedBy(0.5);
    }];
    
    //底部
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(160);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method
-(void)clickAction:(UIButton *)button {
    NSUInteger tag = [button tag];
    switch (tag) {
        case 1001: {
            XBYLogFunc
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case 1002: {
            button.selected = !button.selected;
            if (!button.selected) {
                [self.middleView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.topView.mas_bottom).offset(50);
                    make.left.equalTo(self.view);
                    make.height.equalTo(@200);
                    make.width.equalTo(self.view).multipliedBy(2.0);
                }];
                [self.loginOrRegisterBtn setTitle:@"快速注册" forState:UIControlStateNormal];
                
            } else {
                [self.middleView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.topView.mas_bottom).offset(50);
                    make.right.equalTo(self.view);
                    make.height.equalTo(@200);
                    make.width.equalTo(self.view).multipliedBy(2.0);
                }];
                [self.loginOrRegisterBtn setTitle:@"已有帐号" forState:UIControlStateNormal];
            }

            
            [UIView animateWithDuration:0.25 animations:^{
                [self.view layoutIfNeeded];
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Getter
ImageViewGetter(bgImageView, @"login_register_background")

ViewGetter(topView, [UIColor clearColor])
ButtonGetterWithCode(cancelBtn, [UIColor clearColor], [UIFont systemFontOfSize:12], [UIImage imageNamed:@"login_close_icon"], 0, [_cancelBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];_cancelBtn.tag = 1001;)
ButtonGetterWithCode(loginOrRegisterBtn, [UIColor whiteColor], [UIFont systemFontOfSize:15], nil, 0, [_loginOrRegisterBtn setTitle:@"快速注册" forState:UIControlStateNormal];[_loginOrRegisterBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];_loginOrRegisterBtn.tag = 1002;)

ViewGetter(middleView, [UIColor clearColor])
PropertyGetter(loginView, XBYLoginInputView)
PropertyGetter(registerView, XBYRegisterInputView)

PropertyGetter(bottomView, XBYQuicklyLoginView)


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
