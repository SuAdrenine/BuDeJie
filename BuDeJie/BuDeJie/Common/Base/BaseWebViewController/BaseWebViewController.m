//
//  BaseWebViewController.m
//  BuDeJie
//
//  Created by xby on 2017/6/21.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "BaseWebViewController.h"
#import <Masonry.h>

@interface BaseWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.titles;
    [self.view addSubview:self.webView];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [self.webView loadRequest:request];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    }
    
    return _webView;
}

@end
