//
//  XBYTopicViewController.m
//  BuDeJie
//
//  Created by xby on 2017/7/5.
//  Copyright © 2017年 xby. All rights reserved.
//

#import "XBYTopicViewController.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>
#import "XBYTopic.h"
#import "XBYTopicCell.h"
#import "XBYCommentViewController.h"
#import "XBYRefreshHeard.h"
#import "XBYRefreshFooter.h"
#import "XBYSessionManager.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface XBYTopicViewController ()

@property (nonatomic, strong) NSMutableArray<XBYTopic *> *dataArray;
@property (nonatomic, weak) XBYSessionManager *manager;
@property (nonatomic, copy) NSString *maxTime;

-(NSString *)list;

@end

@implementation XBYTopicViewController

static NSString * const ReuseCellId = @"XBYTopicCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupTableView {
    self.tableView.contentInset = UIEdgeInsetsMake(64+35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [self getRefresh];
    
    [self.tableView registerClass:[XBYTopicCell class] forCellReuseIdentifier:ReuseCellId];
}

/**
 上下拉刷新控件
 */
-(void)getRefresh {
    self.tableView.backgroundColor = XBYCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [XBYRefreshHeard headerWithRefreshingTarget:self refreshingAction:@selector(getNetData)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [XBYRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

/**
 加载最新数据
 */
-(void)getNetData {
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = self.list;
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    
    __weak typeof(self) weakSelf = self;
    [self.manager GET:XBY_Url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _maxTime = responseObject[@"info"][@"maxtime"];
        weakSelf.dataArray = [XBYTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

/**
 加载更多数据
 */
-(void)loadMore {
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = self.list;
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = _maxTime;
    
    __weak typeof(self) weakSelf = self;
    [self.manager GET:XBY_Url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _maxTime = responseObject[@"info"][@"maxtime"];
        NSArray *array = [XBYTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [weakSelf.dataArray addObjectsFromArray:array];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    
}

-(TopicType)type {
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XBYTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseCellId];
    if (!cell) {
        cell = [[XBYTopicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReuseCellId];
    }
    
    cell.topicModel = self.dataArray[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [tableView fd_heightForCellWithIdentifier:ReuseCellId cacheByIndexPath:indexPath configuration:^(id cell) {
        ((XBYTopicCell *)cell).topicModel = self.dataArray[indexPath.row];
    }];
    return height;
//    return 180;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XBYCommentViewController *commentVC = [[XBYCommentViewController alloc] init];
    commentVC.topicModel = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:commentVC animated:YES];
}
/**
 *  数据源懒加载
 */
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

/**
 *  请求对象懒加载
 */
- (XBYSessionManager *)manager {
    if (!_manager) {
        self.manager = [XBYSessionManager manager];
    }
    return _manager;
}

- (NSString *)list {
    if ([self.parentViewController isKindOfClass:NSClassFromString(@"XBYNewpostViewController")]) return @"newlist";
    return @"list";
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
