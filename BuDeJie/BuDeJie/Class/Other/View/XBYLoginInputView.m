//
//  XBYLoginInputView.m
//  BuDeJie
//
//  Created by xby on 2017/7/6.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "XBYLoginInputView.h"
#import <Masonry.h>
#import <NSString+YYAdd.h>

@interface XBYLoginInputView ()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *passwordTF;

@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *forgetPWDBtn;
@end

@implementation XBYLoginInputView

-(instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    
    return self;
}

-(void)setupSubViews {
    [self addSubview:self.bgImageView];
    [self addSubview:self.nameTF];
    [self addSubview:self.passwordTF];
    
    [self addSubview:self.loginBtn];
    [self addSubview:self.forgetPWDBtn];
    
}
-(void)layoutSubviews {
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(50);
        make.height.mas_equalTo(96);
    }];
    
    [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.bgImageView);
        make.height.equalTo(@45);
        
    }];
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.bgImageView);
        make.height.equalTo(@45);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImageView.mas_bottom).offset(20);
        make.left.right.equalTo(self.bgImageView);
        make.height.equalTo(@40);
        
    }];
    
    [self.forgetPWDBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.loginBtn).offset(-5);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 24));
    }];
}

#pragma mark - Method
/**
 获取用户名
 */
-(NSString *)getUserName{
    return self.nameTF.text;
}

/**
 获取明文密码
 */
-(NSString *)getPassword{
    return self.passwordTF.text;
}

/**
 获取MD5密码
 */
-(NSString *)getMD5Password {
    return [self.passwordTF.text md5String];
}

-(void)clickACtion:(UIButton *)button {
    NSUInteger tag = [button tag];
    switch (tag) {
        case 1001: {
            
        }
            break;
        case 1002: {
            
        }
            break;
        default:
            break;
    }

}

#pragma mark - Getter

ImageViewGetter(bgImageView, @"login_rgister_textfield_bg")

-(UITextField *)nameTF {
    if (!_nameTF) {
        _nameTF = [[UITextField alloc] init];
        _nameTF.placeholder = @"帐号";
        _nameTF.placeholderColor = ColorFromRGB(0xaaaaaa);
    }
    
    return _nameTF;
}

-(UITextField *)passwordTF {
    if (!_passwordTF) {
        _passwordTF = [[UITextField alloc] init];
        _passwordTF.placeholder = @"密码";
        _passwordTF.placeholderColor = ColorFromRGB(0xaaaaaa);
    }
    
    return _passwordTF;
}

ButtonGetterWithCode(loginBtn, [UIColor whiteColor], [UIFont systemFontOfSize:CalcFont(15.5)], nil, 0,
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(clickACtion:) forControlEvents:UIControlEventTouchUpInside];[_loginBtn setBackgroundImage:[UIImage imageNamed:@"login_register_button"] forState:UIControlStateNormal];)
ButtonGetterWithCode(forgetPWDBtn, [UIColor whiteColor], [UIFont systemFontOfSize:CalcFont(14.5)], nil, 0,
    [_forgetPWDBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [_forgetPWDBtn addTarget:self action:@selector(clickACtion:) forControlEvents:UIControlEventTouchUpInside];_forgetPWDBtn.tag = 1002;)

@end
