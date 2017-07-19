//
//  XBYRecommendViewController.m
//  BuDeJie
//
//  Created by xby on 2017/7/5.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "XBYRecommendViewController.h"
#import "XBYRecommendTableViewCell.h"
#import "XBYRecommendModel.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <Masonry.h>
#import "XBYRefreshHeard.h"

@interface XBYRecommendViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation XBYRecommendViewController

static NSString * const ReuseCellId = @"XBYRecommendTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"推荐标签";
    
    [self setupTableView];
    [self getData];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //1、取消所有任务
    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //2、移除会话管理者 invalidateSessionCancelingTasks:是否需要任务完成后再取消，这里填NO
    [self.manager invalidateSessionCancelingTasks:NO];
    
    //3、取消指示器
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method
-(void)getData {
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"tag_recommend" forKey:@"a"];
    [parameters setValue:@"sub" forKey:@"action"];
    [parameters setValue:@"topic" forKey:@"c"];
    
    __weak typeof(self) weakSelf = self;
    [self.manager GET:XBY_Url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        _dataSource = [XBYRecommendModel mj_objectArrayWithKeyValuesArray:responseObject];
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}

-(void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[XBYRecommendTableViewCell class] forCellReuseIdentifier:ReuseCellId];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

#pragma mark - TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XBYRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseCellId];
    if (!cell) {
        cell = [[XBYRecommendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReuseCellId];
    }
    
    cell.model = _dataSource[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark - Getter
-(NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

-(AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
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
