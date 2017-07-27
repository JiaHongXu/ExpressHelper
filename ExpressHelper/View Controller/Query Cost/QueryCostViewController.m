//
//  QueryCostViewController.m
//  ExpressHelper
//
//  Created by 307A on 2016/10/30.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "QueryCostViewController.h"
#import "ChooseCityViewController.h"
#import "RouteListViewController.h"

#import "QueryCostModel.h"

@interface QueryCostViewController ()<UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate>
@property (strong, nonatomic) UITableView *chooseCityTableView;
@property (strong, nonatomic) UITableView *chooseWeightTableView;

@property (strong, nonatomic) UIView *exchangeView;
@property (strong, nonatomic) UIButton *exchangeBtn;
@property (strong, nonatomic) UILabel *chooseCityLbl;
@property (strong, nonatomic) UILabel *chooseWeightLbl;
@property (strong, nonatomic) UIButton *calCostBtn;
@property (strong, nonatomic) UISlider *weightSlider;
@property (strong, nonatomic) UIView *sliderView;

@property (assign, nonatomic) NSInteger dismissTime;

@property (strong, nonatomic) NSString *fromCity;
@property (strong, nonatomic) NSString *toCity;
@property (strong, nonatomic) NSString *weight;

@property (strong, nonatomic) NSTimer *timer;

@end

static NSString * const cellId = @"QueryTableViewCell";

@implementation QueryCostViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initConstraints];
    [self initData];
}

- (void)initConstraints {
    //选择出发与目的地城市的两个TableView
    [self.chooseCityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide).with.offset(3*kKDDimensOffsetTop);
        make.left.equalTo(self.view.mas_left).with.offset(kKDDimensOffsetEdge);
        make.right.equalTo(self.view.mas_right).with.offset(-kKDDimensOffsetEdge);
        make.height.mas_equalTo(@119);
    }];
    
    
    [self.exchangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.and.bottom.equalTo(self.chooseCityTableView);
        make.width.mas_equalTo(@60);
    }];
    
    
    [self.exchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.exchangeView);
        make.height.and.width.mas_equalTo(kKDDimensSizeItem);
    }];
    
    
    //选择出发与目的地的Label
    [self.chooseCityLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.chooseCityTableView.mas_top).with.offset(-kKDDimensSpacingDefault/2);
        make.left.equalTo(self.chooseCityTableView.mas_left).with.offset(kKDDimensSpacingDefault/2);
    }];
    
    [self.chooseWeightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chooseCityTableView.mas_bottom).with.offset(2*kKDDimensOffsetEdge);
        make.left.and.right.equalTo(self.chooseCityTableView);
        make.height.mas_equalTo(@59);
    }];
    
    //选择重量的Label
    [self.chooseWeightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.chooseWeightTableView.mas_top).with.offset(-kKDDimensSpacingDefault/2);
        make.left.equalTo(self.chooseWeightTableView.mas_left).with.offset(kKDDimensSpacingDefault/2);
    }];
    
    [self.calCostBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chooseWeightTableView.mas_bottom).with.offset(90);
        make.left.and.right.equalTo(self.chooseWeightTableView);
        make.height.mas_equalTo(@60);
    }];
    
    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.height.equalTo(self.chooseWeightTableView);
        make.top.equalTo(self.chooseWeightTableView.mas_bottom);
    }];
    
    [self.weightSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.sliderView);
        make.left.equalTo(self.sliderView.mas_left).with.offset(kKDDimensOffsetEdge);
        make.right.equalTo(self.sliderView.mas_right).with.offset(-kKDDimensOffsetEdge);
    }];
}

- (void)initData {
    //防止scrollview自动填充布局 避免tableview顶部或底部出现空白
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [JHTools colorWithHexStr:kKDColorBackgroundGrayLight];
    self.title = @"运费计算";
    
    _fromCity = @"";
    _toCity = @"";
    _weight = @"";
}

#pragma mark -- Exchange From and To
- (void)exchangeFromTo {
    NSString *temp = _fromCity;
    _fromCity = _toCity;
    _toCity = temp;
    [self.chooseCityTableView reloadData];
}

#pragma mark -- Do Query Cost
- (void)queryExpressCost:(id)sender {
    if ([_fromCity isEqualToString:@""]) {
        [self showAlertWithMsg:@"请选择出发地"];
        return;
    }else if ([_toCity isEqualToString:@""]) {
        [self showAlertWithMsg:@"请选择目的地"];
        return;
    }else if ([_weight isEqualToString:@""]) {
        [self showAlertWithMsg:@"请选择货物重量"];
        return;
    }
    
    RouteListViewController *routeListViewController = [[RouteListViewController alloc] initWithQueryCostModel:[[QueryCostModel alloc] initFrom:_fromCity to:_toCity weight:_weight]];
    
    [self.navigationController pushViewController:routeListViewController animated:YES];
}

#pragma mark - Respond Methods
- (void)didClickWeightBtn {
    [self showSlideView];
}

- (void)sliderDidDrag {
    _dismissTime = 2;
    _weight = [NSString stringWithFormat:@"%.1f", [self getExactValue:_weightSlider.value]];
    [_chooseWeightTableView reloadData];
}

#pragma mark - Private Methods
- (void)showSlideView {
    WS(ws);
    _sliderView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _sliderView.alpha = 1;
        [_sliderView layoutIfNeeded];
    } completion:^(BOOL finished) {
        _dismissTime = 2;
        [_sliderView layoutIfNeeded];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            ws.dismissTime--;
            if(ws.dismissTime==0){
                [ws.timer invalidate];
                ws.timer = nil;
                [ws hideSlideView];
            };
        }];
    }];
    
}

- (void)hideSlideView {
    [UIView animateWithDuration:0.3 animations:^{
        _sliderView.alpha = 0;
    } completion:^(BOOL finished) {
        _sliderView.hidden = YES;
    }];
}

- (float)getExactValue:(float)value {
    if (value<=10) {
        return value;
    }else if (value<=18) {
        return 10.0 + (value - 10)*5.0;
    }else {
        return 50.0 + (value - 18)*25.0;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WS(ws);
    if ([tableView isEqual:_chooseCityTableView]) {
        ChooseCityViewController *chooseCityViewController = [[ChooseCityViewController alloc] init];
        if (indexPath.row==0) {
            chooseCityViewController.didChooseCityBlock = ^(NSString *cityName){
                ws.fromCity = cityName;
                [ws.chooseCityTableView reloadData];
            };
        }else if (indexPath.row==1) {
            chooseCityViewController.didChooseCityBlock = ^(NSString *cityName){
                ws.toCity = cityName;
                [ws.chooseCityTableView reloadData];
            };
        }
        [self.navigationController pushViewController:chooseCityViewController animated:YES];
    }else if ([tableView isEqual:_chooseWeightTableView]) {
        [self didClickWeightBtn];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_chooseCityTableView]) {
        return 2;
    }else if ([tableView isEqual:_chooseWeightTableView]) {
        return 1;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if ([tableView isEqual:_chooseCityTableView]) {
        switch (indexPath.row) {
            case 0:
                if ([_fromCity isEqualToString:@""]) {
                    cell.textLabel.text = @"出发地";
                    [cell.textLabel setTextColor:[UIColor grayColor]];
                }else {
                    cell.textLabel.text = _fromCity;
                    [cell.textLabel setTextColor:[UIColor blackColor]];
                }
                break;
                
            case 1:
                if ([_toCity isEqualToString:@""]) {
                    cell.textLabel.text = @"目的地";
                    [cell.textLabel setTextColor:[UIColor grayColor]];
                }else {
                    cell.textLabel.text = _toCity;
                    [cell.textLabel setTextColor:[UIColor blackColor]];
                }
                break;
        }
        
    }else if ([tableView isEqual:_chooseWeightTableView]) {
        if ([_weight isEqualToString:@""]) {
            cell.textLabel.text = @"重量 kg";
            [cell.textLabel setTextColor:[UIColor grayColor]];
        }else {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ kg", _weight];
            [cell.textLabel setTextColor:[UIColor blackColor]];
        }
    }
    
    return cell;
}

#pragma mark - Override Methods
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private
- (void)setBorder:(UIView *)view {
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGFloat width = scale > 0.0 ? 1.0 / scale : 1.0;
    
    view.layer.borderWidth = width;
    view.layer.borderColor = [[JHTools colorWithHexStr:kKDColorPrimaryGreen] CGColor];
    view.layer.cornerRadius = 5;
}

#pragma mark - Getter
- (UITableView *)chooseCityTableView {
    if (!_chooseCityTableView) {
        _chooseCityTableView = [[UITableView alloc] init];
        _chooseCityTableView.delegate = self;
        _chooseCityTableView.dataSource = self;
        _chooseCityTableView.layer.cornerRadius = 5;
        _chooseCityTableView.scrollEnabled = NO;
        _chooseCityTableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 60);
        _chooseCityTableView.separatorColor = [JHTools colorWithHexStr:kKDColorPrimaryGreen];
        [self setBorder:_chooseCityTableView];
        [self.view addSubview:_chooseCityTableView];
    }
    
    return _chooseCityTableView;
}

- (UITableView *)chooseWeightTableView {
    if (!_chooseWeightTableView) {
        //选择重量的TableViewCell
        _chooseWeightTableView = [[UITableView alloc] init];
        _chooseWeightTableView.backgroundColor = [UIColor whiteColor];
        _chooseWeightTableView.layer.cornerRadius = 5;
        _chooseWeightTableView.delegate = self;
        _chooseWeightTableView.dataSource = self;
        _chooseWeightTableView.scrollEnabled = NO;
        [self setBorder:_chooseWeightTableView];
        [self.view addSubview:_chooseWeightTableView];
    }
    return _chooseWeightTableView;
}

- (UIView *)exchangeView {
    if (!_exchangeView) {
        _exchangeView = [[UIView alloc] init];
        [self.view addSubview:_exchangeView];
    }
    return _exchangeView;
}

- (UIButton *)exchangeBtn {
    if (!_exchangeBtn) {
        _exchangeBtn = [[UIButton alloc] init];
        [_exchangeBtn setImage:[UIImage imageNamed:@"Exchange"] forState:UIControlStateNormal];
        _exchangeBtn.tintColor = [JHTools colorWithHexStr:kKDColorPrimaryGreen];
        [_exchangeBtn.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_exchangeBtn);
            make.height.and.width.mas_equalTo(@27);
        }];
        [_exchangeBtn addTarget:self action:@selector(exchangeFromTo) forControlEvents:UIControlEventTouchUpInside];
        [self.exchangeView addSubview:_exchangeBtn];
    }
    return _exchangeBtn;
}

- (UILabel *)chooseCityLbl {
    if (!_chooseCityLbl) {
        _chooseCityLbl = [[UILabel alloc] init];
        _chooseCityLbl.text = @"出发与目的城市";
        [_chooseCityLbl setFont:[UIFont systemFontOfSize:kKDFontSizeContent]];
        _chooseCityLbl.textColor = [JHTools colorWithHexStr:kKDColorPrimaryGreen];
        [self.view addSubview:_chooseCityLbl];
    }
    return _chooseCityLbl;
}

- (UILabel *)chooseWeightLbl {
    if (!_chooseWeightLbl) {
        _chooseWeightLbl = [[UILabel alloc] init];
        _chooseWeightLbl.text = @"货物重量";
        [_chooseWeightLbl setFont:[UIFont systemFontOfSize:kKDFontSizeContent]];
        _chooseWeightLbl.textColor = [JHTools colorWithHexStr:kKDColorPrimaryGreen];
        [self.view addSubview:_chooseWeightLbl];
    }
    return _chooseWeightLbl;
}

- (UIButton *)calCostBtn {
    if (!_calCostBtn) {
        _calCostBtn = [[UIButton alloc] init];
        [_calCostBtn setTitle:@"计算" forState:UIControlStateNormal];
        _calCostBtn.backgroundColor = [JHTools colorWithHexStr:kKDColorPrimaryGreen];
        [_calCostBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _calCostBtn.layer.cornerRadius = 5;
        [_calCostBtn addTarget:self action:@selector(queryExpressCost:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_calCostBtn];
    }
    return _calCostBtn;
}

- (UIView *)sliderView {
    if (!_sliderView) {
        _sliderView = [[UIView alloc] init];
        _sliderView.alpha = 0;
        _sliderView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_sliderView];
        [self setBorder:_sliderView];
        _sliderView.hidden = YES;
    }
    return _sliderView;
}

- (UISlider *)weightSlider {
    if (!_weightSlider) {
        _weightSlider = [[UISlider alloc] init];
        _weightSlider.minimumValue = 1;
        _weightSlider.maximumValue = 20;
        _weightSlider.value = [_weight isEqualToString:@""]?1.0:[_weight floatValue];
        _weightSlider.minimumTrackTintColor = [JHTools colorWithHexStr:kKDColorPrimaryGreen]
        ;
        _weightSlider.maximumTrackTintColor = [UIColor groupTableViewBackgroundColor];
        _weightSlider.tintColor = [JHTools colorWithHexStr:kKDColorAccentOrange];
        [self.sliderView addSubview:_weightSlider];
        [_weightSlider addTarget:self action:@selector(sliderDidDrag) forControlEvents:UIControlEventValueChanged];
    }
    return _weightSlider;
}
@end
