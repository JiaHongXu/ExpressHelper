//
//  CompanyDetailViewController.m
//  ExpressHelper
//
//  Created by 307A on 2016/10/31.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "CompanyDetailViewController.h"

#import "KDDetailLabelCell.h"

#import "CompanyBean.h"
#import "QueryCompanyModel.h"

static NSString * const defaultCellId = @"defaultCellId";
static NSString * const companyDetailCellId = @"companyDetailCellId";
static NSString * const pureDetailCellId = @"pureDetailCellId";

@interface CompanyDetailViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *companyDetailTableView;
@property (strong, nonatomic) CompanyBean *company;
@property (strong, nonatomic) QueryCompanyModel *queryCompanyModel;
@end

@implementation CompanyDetailViewController

#pragma mark - Init Methods
- (instancetype)initWithCompany:(CompanyBean *)company {
    if (self = [super init]) {
        _company = company;
    }
    return self;
}

- (void)initData {
    self.title = @"公司详情";
}

- (void)initConstraints {
    [self.companyDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initConstraints];
    
    if (!_company.isDetail) {
        [self.companyDetailTableView.mj_header beginRefreshing];
    }
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

#pragma mark - UITableViewDatasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KDDetailLabelCell *detailCell = nil;
    
    NSInteger index = indexPath.row;

    switch (index) {
        case 0: {
            detailCell = [tableView dequeueReusableCellWithIdentifier:pureDetailCellId];
            if (!detailCell) {
                detailCell = [[KDDetailLabelCell alloc] initWithDetailLabelStyle:KDDetailLabelCellStylePureDetail reuseIdentifier:pureDetailCellId];
                [detailCell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            if (index==0) {
                [detailCell.detailLbl setText:_company.companyName];
                [detailCell.detailLbl setFont:[UIFont systemFontOfSize:kKDFontSizeNavTitle weight:UIFontWeightLight]];
                [detailCell.detailLbl setTextColor:[UIColor blackColor]];
            }
        }
            break;
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7: {
            detailCell = [tableView dequeueReusableCellWithIdentifier:defaultCellId];
            if (!detailCell) {
                detailCell = [[KDDetailLabelCell alloc] initWithDetailLabelStyle:KDDetailLabelCellStyleDefault reuseIdentifier:defaultCellId];
                [detailCell setSelectionStyle:UITableViewCellSelectionStyleNone];
                [detailCell.titleLbl setTextColor:[JHTools colorWithHexStr:kKDColorPrimaryGreen]];
                [detailCell.titleLbl setFont:[UIFont systemFontOfSize:kKDFontSizeSecondaryTitle weight:UIFontWeightLight]];
                [detailCell.titleLbl setTextAlignment:NSTextAlignmentCenter];
                [detailCell.detailLbl setFont:[UIFont systemFontOfSize:kKDFontSizeSecondaryTitle weight:UIFontWeightLight]];
                
            }
            
            switch (index) {
                case 1:
                    [detailCell.titleLbl setText:@"地址"];
                    [detailCell.detailLbl setText:_company.address];
                    break;
                case 2:
                    [detailCell.titleLbl setText:@"联系方式"];
                    [detailCell.detailLbl setText:_company.contact];
                    break;
                case 3:
                    [detailCell.titleLbl setText:@"派送范围"];
                    [detailCell.detailLbl setText:_company.availabeRange];
                    break;
                case 4:
                    [detailCell.titleLbl setText:@"不派送范围"];
                    [detailCell.detailLbl setText:_company.unavailableRange];
                    break;
                case 5:
                    [detailCell.titleLbl setText:@"是否到付"];
                    [detailCell.detailLbl setText:_company.daoFu];
                    break;
                case 6:
                    [detailCell.titleLbl setText:@"备注"];
                    [detailCell.detailLbl setText:_company.moreInfo];
                    break;
                case 7:
                    [detailCell.titleLbl setText:@"总部介绍"];
                    [detailCell.detailLbl setText:_company.baseInfo];
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    return detailCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

#pragma mark - Getter
- (UITableView *)companyDetailTableView {
    if (!_companyDetailTableView) {
        _companyDetailTableView = [[UITableView alloc] init];
        
        [self.view addSubview:_companyDetailTableView];
        [_companyDetailTableView setShowsVerticalScrollIndicator:NO];
        [self setExtraCellLineHidden:_companyDetailTableView];
        _companyDetailTableView.delegate = self;
        _companyDetailTableView.dataSource = self;
        [_companyDetailTableView setEstimatedRowHeight:60.];
        [_companyDetailTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        _companyDetailTableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self.queryCompanyModel refreshingAction:@selector(refresh)];
    }
    
    return _companyDetailTableView;
}

- (QueryCompanyModel *)queryCompanyModel {
    if (!_queryCompanyModel) {
        _queryCompanyModel = [[QueryCompanyModel alloc] initWithCompany:_company];
        
        WS(ws);
        [_queryCompanyModel setBlockWithReturnBlock:^(NSString *successMsg) {
            [ws.companyDetailTableView reloadData];
            if ([ws.companyDetailTableView.mj_header isRefreshing]) {
                [ws.companyDetailTableView.mj_header endRefreshing];
            }
        } WithFailureBlock:^(NSString *failureMsg) {
            [ws showFailureWithMsg:failureMsg];
            if ([ws.companyDetailTableView.mj_header isRefreshing]) {
                [ws.companyDetailTableView.mj_header endRefreshing];
            }
        } WithErrorBlock:^(NSString *errorMsg) {
            [ws showAlertWithMsg:errorMsg];
            if ([ws.companyDetailTableView.mj_header isRefreshing]) {
                [ws.companyDetailTableView.mj_header endRefreshing];
            }
        }];
    }
    return _queryCompanyModel;
}
@end
