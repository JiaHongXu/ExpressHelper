//
//  MainNavigationController.m
//  ZhiFeiUser
//
//  Created by 307A on 2016/12/22.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "MainNavigationController.h"

@interface MainNavigationController ()

@end

@implementation MainNavigationController

#pragma mark - Initialize
+ (void)initialize {
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setTintColor:[UIColor whiteColor]];
    [navigationBar setBarTintColor:[JHTools colorWithHexStr:kKDColorPrimaryGreen]];
    [navigationBar setTranslucent:NO];
    [navigationBar setBarStyle:UIBarStyleDefault];
    [navigationBar setTitleTextAttributes:@{
                                            NSForegroundColorAttributeName:[UIColor whiteColor],
                                            NSFontAttributeName:
                                                [UIFont systemFontOfSize:kKDFontSizeNavTitle weight:UIFontWeightRegular],
                                            }];
}

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Override Methods
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = YES;
    
    [super pushViewController:viewController animated:animated];
    
    if (self.topViewController==self.viewControllers[0]) {
        viewController.hidesBottomBarWhenPushed = NO;
    }
}

@end
