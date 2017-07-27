//
//  ChooseCityViewController.h
//  ExpressHelper
//
//  Created by 307A on 2016/10/30.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^DidChooseCityBlock)(NSString *cityName);
@interface ChooseCityViewController : BaseViewController
@property (nonatomic) DidChooseCityBlock didChooseCityBlock;
@end
