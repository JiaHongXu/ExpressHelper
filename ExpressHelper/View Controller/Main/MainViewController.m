//
//  MainViewController.m
//  ExpressHelper
//
//  Created by 307A on 2016/11/2.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "MainViewController.h"
#import "MainNavigationController.h"
#import "QueryCostViewController.h"

#import <Masonry/Masonry.h>

@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UINavigationController *queryCostNavigationController;
@property (nonatomic, strong) QueryCostViewController *queryCostViewController;
@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIViewController *sliderViewController;
@end

static NSString * const cellId = @"DefaultCell";

@implementation MainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initControllers];
}

- (void)initControllers {
    [self initQueryCostViewController];
    
    [self.view addSubview:_queryCostNavigationController.view];
    [self addChildViewController:_queryCostNavigationController];
    
//    [self addChildViewController:self.sliderViewController];
//    [self addChildViewController:self.queryCostViewController];
//    
//    self.containerView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [self.view addSubview:self.containerView];
//    [self.containerView insertSubview:self.sliderViewController.view atIndex:0];
//    [self.containerView insertSubview:self.queryCostNavigationController.view aboveSubview:self.sliderViewController.view];
    
}

- (void)initQueryCostViewController {
    
}

@end
