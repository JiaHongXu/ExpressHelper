//
//  RouteListViewController.m
//  ExpressHelper
//
//  Created by 307A on 2016/10/31.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "RouteListViewController.h"
#import "RouteDetailViewController.h"

#import "RouteListTableViewCell.h"

#import "RouteBean.h"
#import "QueryCostModel.h"

static NSString * const cellId = @"RouteTableViewCell";

@interface RouteListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *routeListTableView;

@property (nonatomic, strong) QueryCostModel *model;
@end

@implementation RouteListViewController
#pragma mark - Init Methods
- (instancetype)initWithQueryCostModel:(QueryCostModel *)model {
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initConstraints];
    [self initData];
    
    [self.routeListTableView.mj_header beginRefreshing];
}

- (void)initConstraints {
    [self.routeListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.and.right.and.bottom.equalTo(self.view);
    }];
}

- (void)initData {
    //防止scrollview自动填充布局 避免tableview顶部或底部出现空白
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"查询结果";
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    [self.routeListTableView displayWitMsg:@"没有快递信息" ifNecessaryForRowCount:self.model.routeArray.count];
    return self.model.routeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RouteListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[RouteListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.routeBean = [self.model.routeArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RouteDetailViewController *routeDetailVC = [[RouteDetailViewController alloc] initWithRoute:_model.routeArray[indexPath.row]];
    [self.navigationController pushViewController:routeDetailVC animated:YES];
}

#pragma mark - Override Methods
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter
- (UITableView *)routeListTableView {
    if (!_routeListTableView) {
        _routeListTableView = [[UITableView alloc] init];
        _routeListTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self.model refreshingAction:@selector(refresh)];
        _routeListTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self.model refreshingAction:@selector(loadMore)];
        _routeListTableView.backgroundColor = [UIColor clearColor];
        _routeListTableView.delegate = self;
        _routeListTableView.dataSource = self;
        _routeListTableView.rowHeight = 64.;
        [self setExtraCellLineHidden:_routeListTableView];
        [self.view addSubview:_routeListTableView];
    }
    
    return _routeListTableView;
}

- (QueryCostModel *)model {
    WS(ws);
    if (!_model.successBlock) {
        _model.successBlock = ^(NSString *successMsg) {
            [ws.routeListTableView reloadData];
            if ([ws.routeListTableView.mj_header isRefreshing]) {
                [ws.routeListTableView.mj_header endRefreshing];
            }
            if ([ws.routeListTableView.mj_footer isRefreshing]) {
                if (ws.model.hasMore) {
                    [ws.routeListTableView.mj_footer endRefreshing];
                } else {
                    [ws.routeListTableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
        };
    }
    if (!_model.errorBlock) {
        _model.errorBlock = ^(NSString *errorMsg) {
            [ws showAlertWithMsg:errorMsg];
            if ([ws.routeListTableView.mj_header isRefreshing]) {
                [ws.routeListTableView.mj_header endRefreshing];
            }
            if ([ws.routeListTableView.mj_footer isRefreshing]) {
                if (ws.model.hasMore) {
                    [ws.routeListTableView.mj_footer endRefreshing];
                } else {
                    [ws.routeListTableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
        };
    }
    if (!_model.failureBlock) {
        _model.failureBlock = ^(NSString *failureMsg) {
            [ws showFailureWithMsg:failureMsg];
            if ([ws.routeListTableView.mj_header isRefreshing]) {
                [ws.routeListTableView.mj_header endRefreshing];
            }
            if ([ws.routeListTableView.mj_footer isRefreshing]) {
                if (ws.model.hasMore) {
                    [ws.routeListTableView.mj_footer endRefreshing];
                } else {
                    [ws.routeListTableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
        };
    }
    
    return _model;
}
@end
