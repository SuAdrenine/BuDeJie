//
//  XBYBaseNavigationController.m
//  BuDeJie
//
//  Created by xby on 2017/7/4.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "XBYBaseNavigationController.h"

@interface XBYBaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation XBYBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interactivePopGestureRecognizer.delegate = self;
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count >0) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationbuttonTrturnClick"] forState:UIControlStateHighlighted];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        [btn sizeToFit];
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        //这里不使用那个分类的原因是这里还带有文字
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

-(void)back {
    [self popViewControllerAnimated:YES];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count >1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
