//
//  XBYEssenceViewController.m
//  BuDeJie
//
//  Created by xby on 2017/7/4.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "XBYEssenceViewController.h"
#import "XBYAllViewController.h"
#import "XBYVoiceViewController.h"
#import "XBYVideoViewController.h"
#import "XBYPictureViewController.h"
#import "XBYWordViewController.h"
#import "XBYRecommendViewController.h"
#import "XBYTitleButton.h"

@interface XBYEssenceViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIButton *selectdBtn;
@property (nonatomic, strong) UIView *indicateView;

@end

@implementation XBYEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNavigation];
    
    [self addChildVC];
    
    [self addChildrenView];
    
    [self setupSubViews];   //添加scrollView要在添加子控制器后面
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Method
-(void)setupNavigation {
    self.view.backgroundColor = XBYCommonBgColor;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(mainTagSubIconClick)];
    
}

-(void)addChildVC {
    XBYAllViewController *all = [[XBYAllViewController alloc] init];
    [self addChildViewController:all];
    
    XBYVideoViewController *video = [[XBYVideoViewController alloc] init];
    [self addChildViewController:video];
    
    XBYVoiceViewController *voice = [[XBYVoiceViewController alloc] init];
    [self addChildViewController:voice];
    
    XBYPictureViewController *picture = [[XBYPictureViewController alloc] init];
    [self addChildViewController:picture];
    
    XBYWordViewController *word = [[XBYWordViewController alloc] init];
    [self addChildViewController:word];
}

-(void)addChildrenView {
    //子控制器索引
    NSUInteger index = self.scrollView.contentOffset.x / XBYkScreenWidth;
    
    //取出子控制器
    UIViewController *childVC = self.childViewControllers[index];
    if ([childVC isViewLoaded]) return;
    
    childVC.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:childVC.view];
}

-(void)mainTagSubIconClick {
    XBYRecommendViewController *recommend = [[XBYRecommendViewController alloc] init];
    [self.navigationController pushViewController:recommend animated:YES];
}

-(void)setupSubViews {
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.titleView];
    
    self.selectdBtn = self.titleView.subviews.firstObject;
    
    self.indicateView = [[UIView alloc] init];
    self.indicateView.XBY_H = 2;
    self.indicateView.XBY_Y = self.titleView.XBY_H - self.indicateView.XBY_H;
    self.indicateView.XBY_W = self.selectdBtn.titleLabel.XBY_W;
    self.indicateView.backgroundColor = [self.selectdBtn titleColorForState:UIControlStateSelected];
    [self.titleView addSubview:self.indicateView];
    
    //立即根据文字内容计算label宽度
    [self.selectdBtn.titleLabel sizeToFit];
    self.indicateView.XBY_W = self.selectdBtn.titleLabel.XBY_W;
    self.indicateView.XBY_centerX = self.selectdBtn.XBY_centerX;
    //默认情况：选中最前面的标题按钮
    self.selectdBtn.selected = YES;
    
}

- (void)btnClick:(UIButton *)clickedBtn {
    self.selectdBtn.selected = NO;
    self.selectdBtn = clickedBtn;
    self.selectdBtn.selected = YES;
    
    //指示器
    [UIView animateWithDuration:0.25 animations:^{
        self.indicateView.XBY_W = clickedBtn.titleLabel.XBY_W;
        self.indicateView.XBY_centerX = clickedBtn.XBY_centerX;
    }];
    
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = clickedBtn.tag * XBYkScreenWidth;
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self addChildrenView];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(!decelerate){
        //这里复制scrollViewDidEndDecelerating里的代码
        NSInteger index = scrollView.contentOffset.x / XBYkScreenWidth;
        UIButton *btn = self.titleView.subviews[index];
        [self btnClick:btn];
        
        [self addChildrenView];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / XBYkScreenWidth;
    UIButton *btn = self.titleView.subviews[index];
    [self btnClick:btn];
    
    [self addChildrenView];
}

#pragma mark - Getter
-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.contentSize = CGSizeMake(self.childViewControllers.count * XBYkScreenWidth, XBYkScreenHeight);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
    }
    return _scrollView;
}

-(UIView *)titleView {
    if (!_titleView) {
        _titleView = [[UIView alloc] init];
        _titleView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        _titleView.XBY_X = 0;
        _titleView.XBY_Y = 64;
        _titleView.XBY_W = XBYkScreenWidth;
        _titleView.XBY_H = 35;
        NSArray *titleArr = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
        CGFloat btnW = XBYkScreenWidth / titleArr.count;
        CGFloat btnH = _titleView.XBY_H;
        
        for (int i = 0; i<titleArr.count; i++) {
            XBYTitleButton *btn = [[XBYTitleButton alloc] init];
            btn.tag = i;
            btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_titleView addSubview:btn];
        }
    }
    
    return _titleView;
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
