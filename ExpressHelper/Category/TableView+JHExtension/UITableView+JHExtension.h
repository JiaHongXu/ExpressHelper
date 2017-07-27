//
//  UITableView+JHExtension.h
//  ZhiFeiClerk
//
//  Created by 307A on 2017/2/13.
//  Copyright © 2017年 徐嘉宏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (JHExtension)

/**
 * 隐藏 table 其余的cell
 */
- (void)setExtraCellLineHidden;

/**
 * @param message tableview 为空时显示的文本
 * @param rowCount tableview 行数
 */
- (void)displayWitMsg:(NSString *)message ifNecessaryForRowCount:(NSUInteger)rowCount;

@end
