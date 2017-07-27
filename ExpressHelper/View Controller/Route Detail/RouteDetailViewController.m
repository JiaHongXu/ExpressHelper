//
//  RouteDetailViewController.m
//  ExpressHelper
//
//  Created by Jiahong Xu on 2017/5/4.
//  Copyright © 2017年 徐嘉宏. All rights reserved.
//

#import "RouteDetailViewController.h"
#import "CompanyDetailViewController.h"

#import "KDDetailLabelCell.h"

#import "RouteBean.h"
#import "CompanyBean.h"
static NSString * const defaultCellId = @"defaultCellId";
static NSString * const companyDetailCellId = @"companyDetailCellId";
static NSString * const pureDetailCellId = @"pureDetailCellId";

@interface RouteDetailViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *routeDetailTableView;
@property (strong, nonatomic) RouteBean *route;
@end

@implementation RouteDetailViewController
#pragma mark - Init Methods
- (instancetype)initWithRoute:(RouteBean *)route {
    if (self = [super init]) {
        _route = route;
    }
    return self;
}

- (void)initData {
    self.title = @"快递详情";
}

- (void)initConstraints {
    [self.routeDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Respond Methods
- (void)onCloseBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==4||indexPath.row==5) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        CompanyDetailViewController *companyDetailVC;
        if (indexPath.row==4) {
            companyDetailVC = [[CompanyDetailViewController alloc] initWithCompany:_route.fromCompany];
        } else if (indexPath.row==5) {
            companyDetailVC = [[CompanyDetailViewController alloc] initWithCompany:_route.toCompany];
        }
        
        [self.navigationController pushViewController:companyDetailVC animated:YES];
    }
}

#pragma mark - UITableViewDatasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KDDetailLabelCell *detailCell = nil;
    
    NSInteger index = indexPath.row;
    
    // 快递公司，价格，时间，是否到付，揽件房，派送方
    
    switch (index) {
        case 0: {
            detailCell = [tableView dequeueReusableCellWithIdentifier:pureDetailCellId];
            if (!detailCell) {
                detailCell = [[KDDetailLabelCell alloc] initWithDetailLabelStyle:KDDetailLabelCellStylePureDetail reuseIdentifier:pureDetailCellId];
                [detailCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            if (index==0) {
                [detailCell.detailLbl setText:_route.companyName];
                [detailCell.detailLbl setFont:[UIFont systemFontOfSize:kKDFontSizeMax weight:UIFontWeightLight]];
                [detailCell.detailLbl setTextColor:[UIColor blackColor]];
            }
        }
            break;
        case 1:
        case 2:
        case 3: {
            detailCell = [tableView dequeueReusableCellWithIdentifier:defaultCellId];
            if (!detailCell) {
                detailCell = [[KDDetailLabelCell alloc] initWithDetailLabelStyle:KDDetailLabelCellStyleDefault reuseIdentifier:defaultCellId];
                [detailCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            
            if (index==1) {
                [detailCell.titleLbl setText:@"价     格"];
                [detailCell.detailLbl setText:[_route.cost stringByAppendingString:@"元"]];
            } else if (index==2) {
                [detailCell.titleLbl setText:@"时     间"];
                [detailCell.detailLbl setText:_route.time];
            } else if (index==3) {
                [detailCell.titleLbl setText:@"到     付"];
                [detailCell.detailLbl setText:_route.daoFu];
            }
            
            [detailCell.titleLbl setTextColor:[JHTools colorWithHexStr:kKDColorPrimaryGreen]];
            [detailCell.titleLbl setFont:[UIFont systemFontOfSize:kKDFontSizePrimaryTitle weight:UIFontWeightLight]];
            [detailCell.titleLbl setTextAlignment:NSTextAlignmentCenter];
            [detailCell.detailLbl setFont:[UIFont systemFontOfSize:kKDFontSizePrimaryTitle weight:UIFontWeightLight]];
        }
            break;
        case 4:
        case 5: {
            detailCell = [tableView dequeueReusableCellWithIdentifier:companyDetailCellId];
            if (!detailCell) {
                detailCell = [[KDDetailLabelCell alloc] initWithDetailLabelStyle:KDDetailLabelCellStyleDefault reuseIdentifier:companyDetailCellId];
                [detailCell setSelectionStyle:UITableViewCellSelectionStyleDefault];
                [detailCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                [detailCell.detailLbl setPreferredMaxLayoutWidth:(SCREEN_WIDTH-detailCell.preferrenceTitleWidth-3*kKDDimensSpacingDefault-kKDDimensSpacingCell)];
            }
            
            if (index==4) {
                [detailCell.titleLbl setText:@"揽件方"];
                [detailCell.detailLbl setText:_route.fromCompany.companyName];
            } else if (index==5) {
                [detailCell.titleLbl setText:@"派送方"];
                [detailCell.detailLbl setText:_route.toCompany.companyName];
            }
            
            [detailCell.titleLbl setTextColor:[JHTools colorWithHexStr:kKDColorPrimaryGreen]];
            [detailCell.titleLbl setFont:[UIFont systemFontOfSize:kKDFontSizePrimaryTitle weight:UIFontWeightLight]];
            [detailCell.titleLbl setTextAlignment:NSTextAlignmentCenter];
            [detailCell.detailLbl setFont:[UIFont systemFontOfSize:kKDFontSizePrimaryTitle weight:UIFontWeightLight]];
        }
            break;
            
        default:
            break;
    }
    return detailCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

#pragma mark - Getter
- (UITableView *)routeDetailTableView {
    if (!_routeDetailTableView) {
        _routeDetailTableView = [[UITableView alloc] init];
        
        [self.view addSubview:_routeDetailTableView];
        [_routeDetailTableView setShowsVerticalScrollIndicator:NO];
        [self setExtraCellLineHidden:_routeDetailTableView];
        _routeDetailTableView.delegate = self;
        _routeDetailTableView.dataSource = self;
        [_routeDetailTableView setEstimatedRowHeight:60.];
        [_routeDetailTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    
    return _routeDetailTableView;
}
@end
