//
//  XBYAdVertisementViewController.m
//  BuDeJie
//
//  Created by xby on 2017/7/4.
//  Copyright © 2017年 xby. All rights reserved.
//
#define XBYCode @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

#import "XBYAdVertisementViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import <Masonry.h>
#import "XBYAdmodel.h"
#import "XBYBaseTabBarController.h"

@interface XBYAdVertisementViewController ()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIButton *skipBtn;
@property (nonatomic, strong) XBYAdmodel *model;
@property (nonatomic, strong) UIImageView *adImageView;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, weak) AFHTTPSessionManager *manager;
@end

@implementation XBYAdVertisementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.skipBtn];
    
    [self setupScreenHeight];
    [self loadAdData];
    //开启定时器
    [self timer];
    
    [self setupFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupFrame {
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideTop);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self.skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-30);
        make.bottom.equalTo(self.view).offset(-115);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
}

#pragma mark - 屏幕适配
-(void)setupScreenHeight {
    //图存在问题，所以都用700的图
    if (iPone6){
        self.bgImageView.image = [UIImage imageNamed:@"LaunchImage-700"];
    }else if (iPone5){
        self.bgImageView.image = [UIImage imageNamed:@"LaunchImage-700"];
    }else if (iPone4){
        self.bgImageView.image = [UIImage imageNamed:@"LaunchImage"];
    } else {    //肾6以上的大屏
        self.bgImageView.image = [UIImage imageNamed:@"LaunchImage-700"];
    }

}

-(void)loadAdData {
    //创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    self.manager = manager;
    
    //请求超时(超时会来到fail的block中)
    manager.requestSerializer.timeoutInterval = 5.0;
    
    //第一种方法解决
    //增加系列化的解析方式
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];

    //请求传递参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = XBYCode;
    
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(responseObject == nil) return ;
        //字典转模型
        NSMutableArray *adArray = [XBYAdmodel mj_objectArrayWithKeyValuesArray:responseObject[@"ad"]];
        
        //取得模型数组的最后一个模型
        XBYAdmodel *adModel = [adArray firstObject];
        self.model = adModel;
        
        //判定一下广告模型是否为空
        if (self.model) {   //有广告
            //设置广告尺寸
            CGFloat w = XBYkScreenWidth;
            CGFloat h = XBYkScreenHeight;
            
            self.adImageView.frame = CGRectMake(0, 0, w, h);
            [self.adImageView sd_setImageWithURL:[NSURL URLWithString:adModel.w_picurl]];
        } else {
            [SVProgressHUD showErrorWithStatus:@"当前没有广告页面"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

-(void)timeChange {
    static int t = 3;
    NSString *str = [NSString stringWithFormat:@"跳过广告(%d)",t];
    [self.skipBtn setTitle:str forState:UIControlStateNormal];
    if (t == -1) {
        [self skipBtnClick];
    }
    t--;
}

-(void)skipBtnClick {
    //移除定时器
    [self.timer invalidate];
    //取消所有任务
    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //移除会话管理者 invalidateSessionCancelingTasks:是否需要任务完成后再取消，这里填NO
    [_manager invalidateSessionCancelingTasks:NO];
    
    //自己增加转场动画的使用
    CATransition *transAnimation = [[CATransition alloc] init];
    transAnimation.type = @"fade";    //推过去
    transAnimation.duration = 0.5f; //动画时间
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transAnimation forKey:nil];
    
    XBYBaseTabBarController *tabBarVC = [[XBYBaseTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
}

-(void)jump {
    NSURL *url = [NSURL URLWithString:_model.ori_curl];
    //判断能否打开URL
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:nil completionHandler:^(BOOL success) {
            
        }];
    }
}

#pragma mark - Getter
#pragma mark 开启定时器
-(NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
    return _timer;
}

-(UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LaunchImage-700"]];
    }
    
    return _bgImageView;
}

-(UIButton *)skipBtn {
    if (!_skipBtn) {
        _skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipBtn.backgroundColor = [UIColor blackColor];
        [_skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_skipBtn setTitle:@"跳过广告(4)" forState:UIControlStateNormal];
        [_skipBtn addTarget:self action:@selector(skipBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _skipBtn;
}

-(UIImageView *)adImageView {
    if (!_adImageView) {
        _adImageView = [[UIImageView alloc] init];
        _adImageView.userInteractionEnabled = YES;
        [self.view insertSubview:_adImageView belowSubview:self.skipBtn];
        
        [_adImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.bgImageView);
            make.bottom.equalTo(self.bgImageView).offset(-150);
        }];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(jump)];
        [_adImageView addGestureRecognizer:pan];
    }
    
    return _adImageView;
}

-(AFHTTPSessionManager *)manager {
    if(!_manager) {
        self.manager = [AFHTTPSessionManager manager];
    }
    
    return _manager;
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
