//
//  ChooseCityViewController.m
//  ExpressHelper
//
//  Created by 307A on 2016/10/30.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "ChooseCityViewController.h"

@interface ChooseCityViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *cityTableView;
@property (nonatomic, strong) UITableView *provinceTableView;
@property (nonatomic, strong) NSArray<NSArray *> *provinceArray;

@property (nonatomic, assign) NSInteger selectedProvinceIndex;
@end

static NSString * const cityCellId = @"CityTableViewCell";
static NSString * const provinceCellId = @"ProvinceTableViewCell";

@implementation ChooseCityViewController
#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initConstraints];
}

- (void)initConstraints {
    
    [self.cityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.right.and.bottom.equalTo(self.view);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.6);
    }];
    
    [self.provinceTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.and.bottom.equalTo(self.view);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.4);
    }];
}

- (void)initData {
    //防止scrollview自动填充布局 避免tableview顶部或底部出现空白
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [JHTools colorWithHexStr:kKDColorPrimaryGreen];
    self.navigationItem.title = @"选择城市";
    self.selectedProvinceIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.provinceTableView]) {
        return self.provinceArray.count;
    } else if ([tableView isEqual:self.cityTableView]) {
        return ((NSArray *)self.provinceArray[_selectedProvinceIndex][1]).count;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.provinceTableView]) {
        _selectedProvinceIndex = indexPath.row;
        [self.cityTableView reloadData];
    } else if ([tableView isEqual:self.cityTableView]) {
        if (_didChooseCityBlock) {
            _didChooseCityBlock(((NSArray *)self.provinceArray[_selectedProvinceIndex][1])[indexPath.row]);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kKDDimensCellHeight;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if ([tableView isEqual:self.provinceTableView]) {
        cell = [tableView dequeueReusableCellWithIdentifier:provinceCellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:provinceCellId];
            cell.backgroundColor = [JHTools colorWithHexStr:kKDColorBackgroundGrayLight];
            cell.textLabel.font = [UIFont systemFontOfSize:kKDFontSizeSecondaryTitle weight:UIFontWeightLight];
        }
        cell.textLabel.text = self.provinceArray[indexPath.row][0];
    } else if ([tableView isEqual:self.cityTableView]) {
        cell = [tableView dequeueReusableCellWithIdentifier:cityCellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cityCellId];
            cell.backgroundColor = [JHTools colorWithHexStr:kKDColorBackgroundGray];
            cell.textLabel.font = [UIFont systemFontOfSize:kKDFontSizeSecondaryTitle weight:UIFontWeightLight];
        }
        cell.textLabel.text = ((NSArray *)self.provinceArray[_selectedProvinceIndex][1])[indexPath.row];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - Getter
- (UITableView *)cityTableView {
    if (!_cityTableView) {
        _cityTableView = [[UITableView alloc] init];
        _cityTableView.delegate = self;
        _cityTableView.dataSource = self;
        _cityTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _cityTableView.backgroundColor  = [JHTools colorWithHexStr:kKDColorBackgroundGray];
        
        [self.view addSubview:_cityTableView];
    }
    return _cityTableView;
}

- (UITableView *)provinceTableView {
    if (!_provinceTableView) {
        _provinceTableView = [[UITableView alloc] init];
        _provinceTableView.delegate = self;
        _provinceTableView.dataSource = self;
        _provinceTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_provinceTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        [self.view addSubview:_provinceTableView];
    }
    return _provinceTableView;
}

- (NSArray<NSArray *> *)provinceArray {
    if (!_provinceArray) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *plistPath = [bundle pathForResource:@"province&city" ofType:@"plist"];
//        _provinceArray = [[NSArray arrayWithContentsOfFile:plistPath] sortedArrayUsingSelector:@selector(compare:)];
        _provinceArray = [NSArray arrayWithContentsOfFile:plistPath];
    }
    
    return _provinceArray;
}

@end
