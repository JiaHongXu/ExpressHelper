//
//  UITableView+EmptyLabel.m
//  ZhiFeiClerk
//
//  Created by 307A on 2017/2/13.
//  Copyright © 2017年 徐嘉宏. All rights reserved.
//

#import "UITableView+JHExtension.h"

@implementation UITableView (JHExtension)

- (void)setExtraCellLineHidden {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:view];
}

- (void)displayWitMsg:(NSString *)message ifNecessaryForRowCount:(NSUInteger)rowCount {
    if (rowCount == 0) {
        // Display a message when the table is empty
        // 没有数据的时候，UILabel的显示样式
        UILabel *messageLabel = [[UILabel alloc] init];
        
        messageLabel.text = message;
        messageLabel.font = [UIFont systemFontOfSize:kKDFontSizeMax weight:UIFontWeightLight];
        messageLabel.textColor = [JHTools colorWithHexStr:kKDColorTextGray];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [messageLabel sizeToFit];
        
        self.backgroundView = messageLabel;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}
@end
