//
//  XBYBaseTabBarController.m
//  BuDeJie
//
//  Created by xby on 2017/7/4.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "XBYBaseTabBarController.h"
#import "XBYBaseNavigationController.h"
#import "XBYEssenceViewController.h"
#import "XBYNewpostViewController.h"
#import "XBYAttentionViewController.h"
#import "XBYMineViewController.h"
#import "BaseTabBar.h"

@interface XBYBaseTabBarController ()

@end

@implementation XBYBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]} forState:UIControlStateSelected];
    
    [self setupChildController:[[XBYEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setupChildController:[[XBYNewpostViewController alloc] init] title:@"最新" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setupChildController:[[XBYAttentionViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setupChildController:[[XBYMineViewController alloc] init] title:@"我的" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    [self setValue:[[BaseTabBar alloc] init] forKey:@"tabBar"];
}

- (void)setupChildController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    vc.title = title;
    if (image.length) {
        vc.tabBarItem.image = [UIImage imageNamed:image];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    
    XBYBaseNavigationController *nav = [[XBYBaseNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
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
