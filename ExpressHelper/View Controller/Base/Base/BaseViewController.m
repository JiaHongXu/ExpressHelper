//
//  BaseViewController.m
//  ChuangYeHuiApp
//
//  Created by 307A on 2016/12/20.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "BaseViewController.h"
#import "JHTools.h"

static const NSTimeInterval interval = 1.5;

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initBaseData];
    [self initBaseView];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)dealloc {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Init Methods
- (void)initBaseData {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)];
    [tapGestureRecognizer setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)initBaseView {
    self.view.backgroundColor = [JHTools colorWithHexStr:kKDColorBackgroundGrayLight];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
}

#pragma mark - Public Methods
- (void)showAlertWithMsg:(NSString *)msg {
    [SVProgressHUD showInfoWithStatus:msg];
    [self performSelector:@selector(dismissHud) withObject:self afterDelay:interval];
}

- (void)startWaitingHud {
    [SVProgressHUD show];
}

- (void)startWaitingHudWithMsg:(NSString *)msg {
    [SVProgressHUD showWithStatus:msg];
}

- (void)dismissHud {
    [SVProgressHUD dismiss];
}

- (void)dismissHudWithMsg:(NSString *)msg {
    [SVProgressHUD showInfoWithStatus:msg];
    [self performSelector:@selector(dismissHud) withObject:self afterDelay:interval];
}

- (void)showSuccessWithMsg:(NSString *)msg {
    [SVProgressHUD showSuccessWithStatus:msg];
    [self performSelector:@selector(dismissHud) withObject:self afterDelay:interval];
}

- (void)showFailureWithMsg:(NSString *)msg {
    [SVProgressHUD showErrorWithStatus:msg];
    [self performSelector:@selector(dismissHud) withObject:self afterDelay:interval];
}

-(void)setExtraCellLineHidden: (UITableView *)tableView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark - Private Methods
- (void)endEdit {
    [self.view endEditing:YES];
}

- (void)didReceiveUserLogout:(NSNotification *)notification {
    // override this method to apply
}

- (void)didReceiveUserLogin:(NSNotification *)notification {
    // override this method to apply
}

- (void)didRecieveThemeChange:(NSNotification *)notification {
    // override this method to apply
}
@end
