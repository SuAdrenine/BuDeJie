//
//  XBYAttentionViewController.m
//  BuDeJie
//
//  Created by xby on 2017/7/4.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "XBYAttentionViewController.h"
#import "XBYShouldRecommendViewController.h"
#import "XBYLoginAndRegisterViewController.h"

@interface XBYAttentionViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *centerLB;
@property (nonatomic, strong) UIButton *button;

@end

@implementation XBYAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    XBYLogFunc
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"friendsRecommentIcon" highlightedImage:@"friendsRecommentIcon-click" target:self action:@selector(mainTagSubIconClick)];
    
    [self setupSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupSubViews {
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.centerLB];
    [self.view addSubview:self.button];
    
    [self.centerLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.centerLB.mas_top).offset(-20);
        make.size.mas_equalTo(CGSizeMake(48, 48));
        make.centerX.equalTo(self.view);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.centerLB.mas_bottom).offset(20);
        make.left.right.equalTo(self.centerLB);
        make.height.equalTo(@40);
    }];
}

-(void)mainTagSubIconClick {
    XBYShouldRecommendViewController *recommend = [[XBYShouldRecommendViewController alloc] init];
    [self.navigationController pushViewController:recommend animated:YES];
}

-(void)loginOrRegisterAction:(UIButton *)button {
    XBYLoginAndRegisterViewController *loginOrRegister = [[XBYLoginAndRegisterViewController alloc] init];
    [self presentViewController:loginOrRegister animated:YES completion:^{
        
    }];
}

#pragma mark - Getter
-(UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header_cry_icon"]];
    }
    
    return _imageView;
}

-(UILabel *)centerLB {
    if (!_centerLB) {
        _centerLB = [UILabel new];
        _centerLB.textAlignment = NSTextAlignmentCenter;
        _centerLB.text = @"快快登录吧，关注百思最in牛人\n好友动态让你过把瘾儿~\n噢耶~~~！";
        _centerLB.numberOfLines = 0;
    }
    
    return _centerLB;
}

-(UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"登录/注册" forState:UIControlStateNormal];
        [_button setBackgroundColor:[UIColor redColor]];
        [_button addTarget:self action:@selector(loginOrRegisterAction:) forControlEvents:UIControlEventTouchUpInside];
        _button.layer.cornerRadius = 3;
    }
    
    return _button;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
