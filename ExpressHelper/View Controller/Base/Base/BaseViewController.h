//
//  BaseViewController.h
//  ChuangYeHuiApp
//
//  Created by 307A on 2016/12/20.
//  Copyright © 2016年 徐嘉宏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface BaseViewController : UIViewController
//show an alert hud with a single string of msg
- (void)showAlertWithMsg:(NSString *)msg;

//start an waiting hud (or waiting hud with msg)
- (void)startWaitingHud;
- (void)startWaitingHudWithMsg:(NSString *)msg;

//dismiss waiting hud (or to show a msg before dismissing after delay)
- (void)dismissHud;
- (void)dismissHudWithMsg:(NSString *)msg;

//show hud with status and msg
- (void)showSuccessWithMsg:(NSString *)msg;
- (void)showFailureWithMsg:(NSString *)msg;

//set extra cell line hidden
- (void)setExtraCellLineHidden: (UITableView *)tableView;

// override these methods to apply
- (void)didReceiveUserLogout:(NSNotification *)notification;
- (void)didReceiveUserLogin:(NSNotification *)notification ;
- (void)didRecieveThemeChange:(NSNotification *)notification;
@end
