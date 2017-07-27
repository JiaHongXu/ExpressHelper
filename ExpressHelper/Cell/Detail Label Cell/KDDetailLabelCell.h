//
//  KDDetailLabelCell.h
//  KDork
//
//  Created by Jiahong Xu on 2017/3/27.
//  Copyright © 2017年 徐嘉宏. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, KDDetailLabelCellStyle) {
    KDDetailLabelCellStyleDefault,      // title label on left, detail label on right
    KDDetailLabelCellStylePureDetail,   // only detail label on right
    KDDetailLabelCellStyleIconDetail,   // icon on left, detail label on right
};
@interface KDDetailLabelCell : UITableViewCell

@property (strong, nonatomic) UIImageView *iconImgView;
@property (strong, nonatomic) UILabel *titleLbl;
@property (strong, nonatomic) UILabel *detailLbl;

@property (assign, nonatomic) CGFloat preferrenceTitleWidth;

- (instancetype)initWithDetailLabelStyle:(KDDetailLabelCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
