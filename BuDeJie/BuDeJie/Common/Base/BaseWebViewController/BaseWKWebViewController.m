//
//  BaseWKWebViewController.m
//  BuDeJie
//
//  Created by xby on 2017/6/21.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "BaseWKWebViewController.h"
#import <WebKit/WebKit.h>

@interface BaseWKWebViewController ()

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) CALayer *progressLayer;

@end

@implementation BaseWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.titles;
    [self.view addSubview:self.webView];
    
    [self.webView addObserver:self forKeyPath:WkwebView options:NSKeyValueObservingOptionNew context:nil];
    UIView *progress = [[UIView alloc] initWithFrame:CGRectMake(0, 70, XBYkScreenWidth, 3)];
    progress.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progress];
    [progress.layer addSublayer:self.progressLayer];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:WkwebView]) {
        NSLog(@"%@",change);
        self.progressLayer.opacity = 1;
        self.progressLayer.frame = CGRectMake(0, 0, XBYSelfViewWidth*[change[NSKeyValueChangeNewKey] floatValue], 3);
        if ([change[NSKeyValueChangeNewKey] floatValue] ==1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressLayer.opacity = 0;
            });
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressLayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(void)dealloc {
    [self.webView removeObserver:self forKeyPath:WkwebView];
}

-(CALayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CALayer layer];
        _progressLayer.frame = CGRectMake(0, 0, 0, 3);
        _progressLayer.backgroundColor = [UIColor redColor].CGColor;
    }
    
    return _progressLayer;
}

-(WKWebView *)webView {
    if(!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    }
    
    return _webView;
}

@end
