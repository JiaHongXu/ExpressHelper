//
//  RouteDetailViewController.h
//  ExpressHelper
//
//  Created by Jiahong Xu on 2017/5/4.
//  Copyright © 2017年 徐嘉宏. All rights reserved.
//

#import "BaseViewController.h"
@class RouteBean;

@interface RouteDetailViewController : BaseViewController
- (instancetype)initWithRoute:(RouteBean *)route;
@end
